require 'rubygems'
require 'bundler/setup'

require 'haml'
require 'json'
require 'ruby-event'

module RubyApp
  require 'ruby_app/mixins/configuration'
  require 'ruby_app/mixins/render'
  require 'ruby_app/mixins/template'
  require 'ruby_app/mixins/translate'

  class Element
    extend RubyApp::Mixins::Configuration
    include RubyApp::Mixins::Configuration
    extend RubyApp::Mixins::Translate
    include RubyApp::Mixins::Translate
    extend RubyApp::Mixins::Template
    include Haml::Helpers
    extend Haml::Helpers
    extend RubyApp::Mixins::Render
    include RubyApp::Mixins::Render

    class Event

      attr_reader :source

      def initialize(data = nil)
        @source = data ? RubyApp::Element.get_element(data['source_id']) : nil
        @statements = []
      end

      def alert(message)
        execute("RubyApp.alert(#{message.to_json});")
      end

      def refresh
        execute("RubyApp.refresh();")
      end

      def show(dialog)
        execute("RubyApp.show('#{dialog.element_id}');")
      end

      def hide(dialog)
        execute("RubyApp.hide('#{dialog.element_id}');")
      end

      def update_element(element)
        execute("RubyApp.updateElement('#{element.element_id}');")
      end

      def update_text(selector, value)
        execute("RubyApp.updateText(#{selector.to_json}, #{value.to_json});")
      end

      def update_value(selector, value)
        execute("RubyApp.updateValue(#{selector.to_json}, #{value.to_json});")
      end

      def go(url)
        execute("RubyApp.go('#{url}');")
      end

      def execute(statement)
        @statements << statement
      end

      def self.from_hash(data)
        eval(data['_class']).new(data)
      end

      def to_hash
        {
          '_class' => self.class.to_s,
          'source_id' => @source ? @source.element_id : nil,
          'statements' => @statements
        }
      end

    end

    class ExceptionEvent < RubyApp::Element::Event

      def initialize(exception)
        super()
        self.alert(exception.message)
      end

    end

    template_path(:all, File.dirname(__FILE__))

    attr_reader :attributes

    event :evented

    def initialize
      @attributes = {:id => element_id}
    end

    def element_id
      "id_#{object_id}"
    end

    def self.get_element(element_id)
      element_id =~ /(\d+)/
      ObjectSpace._id2ref($1.to_i)
    end

    protected

      def on_event(event)
        evented(event)
      end

  end

end
