require 'rubygems'
require 'bundler/setup'

require 'ruby-event'

module RubyApp

  module Elements

    module Mobile
      require 'ruby_app/element'

      class Input < RubyApp::Element

        class ChangedEvent < RubyApp::Element::Event

          attr_reader :value

          def initialize(data)
            super(data)
            @value = data['value'].strip
            @value = @value.empty? ? nil : @value
          end

          def to_hash
            super.merge(:value => @value)
          end

        end

        template_path(:all, File.dirname(__FILE__))

        attr_accessor :value

        event :changed

        def initialize
          super
          self.attributes.merge!(:type => :text)

          @value = nil

        end

        protected

          def on_event(event)
            on_changed(event) if event.is_a?(RubyApp::Elements::Mobile::Input::ChangedEvent)
            super(event)
          end

          def on_changed(event)
            @value = event.value
            changed(event)
          end

      end

    end

  end

end
