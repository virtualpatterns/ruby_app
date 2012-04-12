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

          @stylesheets.push('http://code.jquery.com/mobile/1.1.0-rc.1/jquery.mobile-1.1.0-rc.1.min.css')
          @stylesheets.push("/#{RubyApp::Language.locale.code}/document.css")

          @scripts.push('http://code.jquery.com/jquery-1.7.1.js')
          @scripts.push('http://code.jquery.com/mobile/1.1.0-rc.1/jquery.mobile-1.1.0-rc.1.js')
          @scripts.push("/#{RubyApp::Language.locale.code}/document.js")

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
