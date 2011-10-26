require 'rubygems'
require 'bundler/setup'

require 'ruby-event'

module RubyApp

  module Elements
    require 'ruby_app/element'

    class Markdown < RubyApp::Element

      class NavigatedEvent < RubyApp::Element::Event

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

      event :navigated

      def initialize
        super
      end

      protected

        def on_event(event)
          on_navigated(event) if event.is_a?(RubyApp::Elements::Markdown::NavigatedEvent)
          super(event)
        end

        def on_navigated(event)
          navigated(event)
        end

    end

  end

end
