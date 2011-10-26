require 'rubygems'
require 'bundler/setup'

require 'chronic_duration'

module RubyApp

  module Elements

    module Inputs
      require 'ruby_app/elements/input'

      class DurationInput < RubyApp::Elements::Input

        template_path(:all, File.dirname(__FILE__))

        attr_accessor :duration

        def initialize
          super
        end

        def duration=(value)
          @duration = value
          @value = ChronicDuration.output(@duration)
        end

        protected

          def on_changed(event)
            duration = ChronicDuration.parse(event.value)
            if duration
              @duration = duration
              @value = ChronicDuration.output(@duration)
              event.update_value("##{self.element_id}", @value)
              changed(event)
            end
          end

      end

    end

  end

end
