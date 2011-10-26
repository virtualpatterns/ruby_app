require 'rubygems'
require 'bundler/setup'

require 'ruby-event'

module RubyApp

  module Elements

    module Base
      require 'ruby_app/element'
      require 'ruby_app/language'

      class BasePage < RubyApp::Element

        class LoadedEvent < RubyApp::Element::Event

          def initialize(data)
            super(data)
          end

        end

        class TriggeredEvent < RubyApp::Element::Event

          def initialize(data)
            super(data)
          end

        end

        class ReleasedEvent < RubyApp::Element::Event

          def initialize(data)
            super(data)
          end

        end

        template_path(:all, File.dirname(__FILE__))

        attr_accessor :interval

        event :loaded
        event :triggered
        event :released

        def initialize
          super
          @interval = 0
        end

        protected

          def on_event(event)
            on_loaded(event) if event.is_a?(RubyApp::Elements::Base::BasePage::LoadedEvent)
            on_triggered(event) if event.is_a?(RubyApp::Elements::Base::BasePage::TriggeredEvent)
            on_released(event) if event.is_a?(RubyApp::Elements::Base::BasePage::ReleasedEvent)
            super(event)
          end

          def on_loaded(event)
            loaded(event)
          end

          def on_triggered(event)
            triggered(event)
          end

          def on_released(event)
            released(event)
          end

      end

    end

  end

end
