require 'rubygems'
require 'bundler/setup'

require 'haml'
require 'json'
require 'mime/types'
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

      attr_reader :session_id, :now, :source

      def initialize(data = nil)
        if data
          @session_id = data['session_id']
          @now = Time.parse(data['now'])
          @source = RubyApp::Element.get_element(data['source_id'])
        else
          @session_id = nil
          @now = Time.now
          @source = nil
        end
        @statements = []
      end

      def today
        @now.send(:to_date)
      end

      def process!
        raise RubyApp::Exceptions::SessionInvalidException.new(RubyApp::Request.POST['session_id']) unless self.session_id == RubyApp::Session.session_id
        source.send(:on_event, self)
      end

      def log(message)
        execute("RubyApp.log(#{message.to_json});")
      end

      def alert(message)
        execute("RubyApp.alert(#{message.to_json});")
      end

      def refresh
        execute("RubyApp.refresh();")
      end

      def confirm_refresh(message)
        execute("RubyApp.confirmRefresh(#{message.to_json});")
      end

      def show_dialog(dialog)
        execute("RubyApp.showDialog('#{dialog.element_id}');")
      end

      def hide_dialog(dialog)
        execute("RubyApp.hideDialog('#{dialog.element_id}');")
      end

      def update_element(element)
        execute("RubyApp.updateElement('#{element.element_id}');")
      end

      def add_class(selector, _class)
        execute("RubyApp.addClass(#{selector.to_json}, #{_class.to_json});")
      end

      def remove_class(selector, _class)
        execute("RubyApp.removeClass(#{selector.to_json}, #{_class.to_json});")
      end

      def update_text(selector, value)
        execute("RubyApp.updateText(#{selector.to_json}, #{value.to_json});")
      end

      def update_value(selector, value)
        execute("RubyApp.updateValue(#{selector.to_json}, #{value.to_json});")
      end

      def go(url)
        execute("RubyApp.go(#{url.to_json});")
      end

      def set_cookie(name, value, expires = Time.now + 365*24*60*60)
        execute("RubyApp.setCookie(#{name.to_json}, #{value.to_json}, new Date(#{expires.year}, #{expires.month - 1}, #{expires.day}, #{expires.hour}, #{expires.min}, #{expires.sec}));")
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
        eval(data['_class']).new(data)
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

    def initialize
      @attributes = {:id => self.element_id}
    end

    def element_id
      "id_#{object_id}"
    end

    def self.get_element(element_id)
      element_id =~ /(-?\d+)/
      ObjectSpace._id2ref($1.to_i)
    end

    def self.get_content_type(format)
      ( mime_type = MIME::Types.type_for(format)[0] ) ? mime_type.content_type : 'text/plain'
    end

    protected

      def on_event(event)
        evented(event)
      end

  end

end
