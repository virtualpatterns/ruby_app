require 'rubygems'
require 'bundler/setup'

require 'ruby-event'

module RubyApp

  module Elements

    module Base
      require 'ruby_app/element'

      class BaseDialog < RubyApp::Element

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

        template_path(:all, File.dirname(__FILE__))

        attr_reader :response

        event :shown
        event :hidden

        def initialize
          super
        end

        protected

          def on_event(event)
            on_shown(event) if event.is_a?(RubyApp::Elements::Base::BaseDialog::ShownEvent)
            on_hidden(event) if event.is_a?(RubyApp::Elements::Base::BaseDialog::HiddenEvent)
            super(event)
          end

          def on_shown(event)
            shown(event)
          end

          def on_hidden(event)
            hidden(event)
          end

      end

    end

  end

end
