require 'rubygems'
require 'bundler/setup'

require 'ruby-event'

module RubyApp

  module Elements

    module Mobile
      require 'ruby_app/element'

      class Page < RubyApp::Element

        class LoadedEvent < RubyApp::Element::Event

          def initialize(data)
            super(data)
          end

        end

        class ShownEvent < RubyApp::Element::Event

          def initialize(data)
            super(data)
          end

        end

        class HiddenEvent < RubyApp::Element::Event

          def initialize(data)
            super(data)
          end

        end

        class SwipedEvent < RubyApp::Element::Event

          def initialize(data)
            super(data)
          end

        end

        class SwipedLeftEvent < RubyApp::Elements::Mobile::Page::SwipedEvent

          def initialize(data)
            super(data)
          end

          def left?
            return true
          end

          def right?
            return false
          end

        end

        class SwipedRightEvent < RubyApp::Elements::Mobile::Page::SwipedEvent

          def initialize(data)
            super(data)
          end

          def left?
            return false
          end

          def right?
            return true
          end

        end

        template_path(:all, File.dirname(__FILE__))

        event :loaded
        event :shown
        event :hidden
        event :removed
        event :swiped

        def initialize
          super
          self.attributes.merge!('data-role' => 'page')
        end

        def show(event, options = {})
          RubyApp::Session.document.pages.push(self)
          event.show_page(RubyApp::Session.document.pages.last, options)
        end

        def hide(event, options = {})
          event.show_page(RubyApp::Session.document.pages.second_last, options)
        end

        protected

          def on_event(event)
            on_loaded(event) if event.is_a?(RubyApp::Elements::Mobile::Page::LoadedEvent)
            on_shown(event) if event.is_a?(RubyApp::Elements::Mobile::Page::ShownEvent)
            on_hidden(event) if event.is_a?(RubyApp::Elements::Mobile::Page::HiddenEvent)
            on_swiped(event) if event.is_a?(RubyApp::Elements::Mobile::Page::SwipedEvent)
            super(event)
          end

          def on_loaded(event)
            loaded(event)
          end

          def on_shown(event)
            shown(event)
          end

          def on_hidden(event)
            hidden(event)
            if RubyApp::Session.document.pages.last == self
              RubyApp::Session.document.pages.pop
              removed(event)
              event.remove_page(self)
            end
          end

          def on_swiped(event)
            swiped(event)
          end

      end

    end

  end

end
