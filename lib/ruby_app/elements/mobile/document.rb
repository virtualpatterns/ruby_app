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

          @stylesheets.push("#{RubyApp.root.nil_if('/')}/ruby_app/resources/elements/mobile/document/jquery.mobile-1.1.0/jquery.mobile-1.1.0.min.css")

          @scripts.push("#{RubyApp.root.nil_if('/')}/ruby_app/resources/elements/mobile/document/jquery-1.8.3.min.js")
          @scripts.push("#{RubyApp.root.nil_if('/')}/ruby_app/resources/elements/mobile/document/jquery-ui-1.9.2.custom/js/jquery-ui-1.9.2.custom.min.js")
          @scripts.push("#{RubyApp.root.nil_if('/')}/ruby_app/resources/elements/mobile/document/jquery.ui.touch-punch-0.2.2.min.js")
          @scripts.push("#{RubyApp.root.nil_if('/')}/ruby_app/resources/elements/mobile/document/fastclick-0.5.6.js")
          @scripts.push("#{RubyApp.root.nil_if('/')}/ruby_app/resources/elements/mobile/document/document.js")
          @scripts.push("#{RubyApp.root.nil_if('/')}/ruby_app/resources/elements/mobile/document/jquery.mobile-1.1.0/jquery.mobile-1.1.0.min.js")

        end

        def page
          return @pages.last
        end

        def show(event, url = RubyApp.root)
          RubyApp::Session.documents.push(self)
          event.go(url)
        end

        def hide(event, url = RubyApp.root)
          RubyApp::Session.documents.pop
          event.go(url)
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
