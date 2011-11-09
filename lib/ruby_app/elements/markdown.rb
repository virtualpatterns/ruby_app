require 'rubygems'
require 'bundler/setup'

require 'ruby-event'

module RubyApp

  module Elements
    require 'ruby_app/element'

    class Markdown < RubyApp::Element

      class ClickedEvent < RubyApp::Element::Event

        attr_reader :name

        def initialize(data)
          super(data)
          @name = data['name']
        end

        def to_hash
          super.merge('name' => @name)
        end

      end

      template_path(:all, File.dirname(__FILE__))

      event :clicked

      def initialize
        super
      end

      protected

        def on_event(event)
          on_clicked(event) if event.is_a?(RubyApp::Elements::Markdown::ClickedEvent)
          super(event)
        end

        def on_clicked(event)
          clicked(event)
        end

    end

  end

end
