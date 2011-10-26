require 'rubygems'
require 'bundler/setup'

require 'ruby-event'

module RubyApp

  module Elements
    require 'ruby_app/element'

    class Click < RubyApp::Element

      class ClickedEvent < RubyApp::Element::Event

        def initialize(data)
          super(data)
        end

      end

      template_path(:all, File.dirname(__FILE__))

      event :clicked

      def initialize
        super
      end

      protected

        def on_event(event)
          on_clicked(event) if event.is_a?(RubyApp::Elements::Click::ClickedEvent)
          super(event)
        end

        def on_clicked(event)
          clicked(event)
        end

    end

  end

end
