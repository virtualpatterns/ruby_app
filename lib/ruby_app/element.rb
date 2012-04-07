require 'rubygems'
require 'bundler/setup'

require 'haml'
require 'json'
require 'ruby-event'

module RubyApp
  require 'ruby_app/exceptions'
  require 'ruby_app/mixins'

  class Element
    extend RubyApp::Mixins::ConfigurationMixin
    include RubyApp::Mixins::ConfigurationMixin
    extend RubyApp::Mixins::TranslateMixin
    include RubyApp::Mixins::TranslateMixin
    extend RubyApp::Mixins::TemplateMixin
    extend Haml::Helpers
    include Haml::Helpers
    extend RubyApp::Mixins::RenderMixin
    include RubyApp::Mixins::RenderMixin

    class Event
      extend RubyApp::Mixins::TranslateMixin

      attr_reader :session, :now, :source

      def initialize(data = nil)
        if data
          @now = Time.parse(data['now'])

          session = RubyApp::Session.get_session(data['session'])
          raise RubyApp::Exceptions::SessionInvalidException.new(data['session']) unless session
          @session = session

          source = RubyApp::Element.get_element(data['source'])
          raise RubyApp::Exceptions::ElementInvalidException.new(data['source']) unless source
          @source = source

        else
          @now = Time.now
          @session = nil
          @source = nil
        end
        @statements = []
      end

      def today
        @now.send(:to_date)
      end

      def process!
        self.source.send(:on_event, self)
      end

      def refresh
        self.execute("RubyApp.refresh();")
      end

      def confirm_refresh(message)
        self.execute("RubyApp.confirmRefresh(#{message.to_json});")
      end

      def show_page(page, options = {})
        options.merge!(:changeHash => false)
        self.execute("RubyApp.showPage(#{page.element_id.to_json}, #{options.to_json});")
      end

      def remove_page(page)
        self.execute("RubyApp.removePage(#{page.element_id.to_json});")
      end

      def update_element(element)
        self.execute("RubyApp.updateElement(#{element.element_id.to_json});")
      end

      def create_trigger(element, interval)
        self.execute("RubyApp.createTrigger(#{element.element_id.to_json}, #{(interval * 1000).to_json});")
      end

      def destroy_trigger(element)
        self.execute("RubyApp.destroyTrigger(#{element.element_id.to_json});")
      end

      def quit!
        self.go('/quit')
      end

      def go(url)
        self.execute("RubyApp.go(#{url.to_json});")
      end

      def add_class(selector, _class)
        self.execute("RubyApp.addClass(#{selector.to_json}, #{_class.to_json});")
      end

      def remove_class(selector, _class)
        self.execute("RubyApp.removeClass(#{selector.to_json}, #{_class.to_json});")
      end

      def update_text(selector, value)
        self.execute("RubyApp.updateText(#{selector.to_json}, #{value.to_json});")
      end

      def update_value(selector, value)
        self.execute("RubyApp.updateValue(#{selector.to_json}, #{value.to_json});")
      end

      def update_input(text, value)
        self.update_value_for("label:contains('#{text}')", value)
      end

      def update_value_for(selector, value)
        self.execute("RubyApp.updateValueFor(#{selector.to_json}, #{value.to_json});")
      end

      def set_cookie(name, value, expires = Time.now + 365*24*60*60)
        self.execute("RubyApp.setCookie(#{name.to_json}, #{value.to_json}, new Date(#{expires.year}, #{expires.month - 1}, #{expires.day}, #{expires.hour}, #{expires.min}, #{expires.sec}));")
      end

      def tap_link(text)
        self.tap_selector("a:contains('#{text}')")
      end

      def tap_selector(selector)
        _selector = ".ui-page-active #{selector}"
        self.execute("RubyApp.tap(#{_selector.to_json});")
      end

      def assert_exists_text(text)
        self.assert_exists_selector("*:contains('#{text}')")
      end

      def assert_exists_link(text)
        self.assert_exists_selector("a:contains('#{text}')")
      end

      def assert_exists_selector(selector)
        _selector = ".ui-page-active #{selector}"
        self.execute("RubyApp.assertExists(#{_selector.to_json});")
      end

      def assert_exists_input(text, value = nil)
        self.assert_exists_selector_for("label:contains('#{text}')") unless value
        self.assert_exists_selector_value_for("label:contains('#{text}')", value) if value
      end

      def assert_exists_selector_for(selector)
        _selector = ".ui-page-active #{selector}"
        self.execute("RubyApp.assertExistsFor(#{_selector.to_json});")
      end

      def assert_exists_selector_value_for(selector, value)
        _selector = ".ui-page-active #{selector}"
        self.execute("RubyApp.assertExistsValueFor(#{_selector.to_json}, #{value.to_json});")
      end

      def log(message)
        self.execute("RubyApp.log(#{message.to_json});")
      end

      def execute(statement)
        @statements << statement
      end

      def to_hash
        {
          '_class' => self.class.to_s,
          'now' => @now,
          'source_id' => @source ? @source.element_id : nil,
          'statements' => @statements
        }
      end

      def self.from_hash(data)
        Kernel.eval(data['_class']).new(data)
      end

    end

    class TriggeredEvent < RubyApp::Element::Event

      def initialize(data)
        super(data)
      end

    end

    class TestedEvent < RubyApp::Element::Event

      def initialize(data)
        super(data)
      end

    end

    class AssertedEvent < RubyApp::Element::TestedEvent

      attr_reader :name
      attr_reader :value

      def initialize(data)
        super(data)
        @name = data['name']
        @value = data['value'].to_b
      end

    end

    class ExceptionEvent < RubyApp::Element::Event

      def initialize(exception)
        super()
        self.confirm_refresh(RubyApp::Element::ExceptionEvent.translate.message(exception.message))
      end

    end

    template_path(:all, File.dirname(__FILE__))

    attr_reader :attributes

    event :evented
    event :triggered
    event :asserted

    def initialize
      @attributes = {:id => self.element_id}
    end

    def element_id
      return "id_#{object_id}"
    end

    def self.get_element(element_id)
      element_id =~ /(-?\d+)/
      return ObjectSpace._id2ref($1.to_i)
    end

    protected

      def on_event(event)
        on_triggered(event) if event.is_a?(RubyApp::Element::TriggeredEvent)
        on_asserted(event) if event.is_a?(RubyApp::Element::AssertedEvent)
        evented(event)
      end

      def on_triggered(event)
        triggered(event)
      end

      def on_asserted(event)
        if event.value
          RubyApp::Log.debug("TRUE  #{event.name}")
        else
          RubyApp::Log.debug("FALSE #{event.name}")
          raise RubyApp::Exceptions::AssertFailedException.new(event.name)
        end
        asserted(event)
      end

  end

end
