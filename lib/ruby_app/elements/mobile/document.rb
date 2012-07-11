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

        attr_reader :metadata
        attr_reader :links
        attr_reader :stylesheets
        attr_reader :scripts

        attr_reader :pages

        event :loaded

        def initialize
          super

          @metadata = {}
          @links = {}
          @stylesheets = []
          @scripts = []

          @pages = []

          @metadata.merge!('viewport' => 'width=device-width, initial-scale=1')

          @stylesheets.push('http://code.jquery.com/mobile/1.1.0/jquery.mobile-1.1.0.min.css')

          @scripts.push('http://code.jquery.com/jquery-1.7.1.min.js')
          @scripts.push('http://code.jquery.com/ui/1.8.21/jquery-ui.min.js')
          @scripts.push('/ruby_app/resources/jquery.ui.touch-punch.min.js')
          @scripts.push('/ruby_app/resources/elements/mobile/document.js')
          @scripts.push('http://code.jquery.com/mobile/1.1.0/jquery.mobile-1.1.0.min.js')

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
