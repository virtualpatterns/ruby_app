require 'rubygems'
require 'bundler/setup'

require 'ruby-event'

module RubyApp

  module Elements

    module Mobile
      require 'ruby_app/element'

      class Document < RubyApp::Element

        class LoadedEvent < RubyApp::Element::Event

          def initialize(data)
            super(data)
          end

        end

        template_path(:all, File.dirname(__FILE__))

        attr_reader :pages

        event :loaded

        def initialize
          super
          @pages = []
        end

        def page
          return @pages.last
        end

        protected

          def on_event(event)
            on_loaded(event) if event.is_a?(RubyApp::Elements::Mobile::Document::LoadedEvent)
            super(event)
          end

          def on_loaded(event)
            loaded(event)
          end

      end

    end

  end

end
