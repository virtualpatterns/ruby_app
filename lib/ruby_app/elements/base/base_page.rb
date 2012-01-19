require 'rubygems'
require 'bundler/setup'

require 'ruby-event'

module RubyApp

  module Elements

    module Base
      require 'ruby_app/element'
      require 'ruby_app/language'
      require 'ruby_app/mixins/hash_mixin'

      class BasePage < RubyApp::Element
        include RubyApp::Mixins::HashMixin

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

        template_path(:all, File.dirname(__FILE__))

        attr_reader :data

        event :loaded
        event :triggered

        def initialize
          super
          @data = {}
        end

        def [](key)
          @data[key]
        end

        def []=(key, value)
          @data[key] = value
        end

        def interval
          return data[:interval]
        end

        def interval=(value)
          data[:interval] = value
        end

        protected

          def on_event(event)
            on_loaded(event) if event.is_a?(RubyApp::Elements::Base::BasePage::LoadedEvent)
            on_triggered(event) if event.is_a?(RubyApp::Elements::Base::BasePage::TriggeredEvent)
            super(event)
          end

          def on_loaded(event)
            loaded(event)
          end

          def on_triggered(event)
            triggered(event)
          end

      end

    end

  end

end
