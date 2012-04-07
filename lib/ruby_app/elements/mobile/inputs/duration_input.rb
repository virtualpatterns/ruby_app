require 'rubygems'
require 'bundler/setup'

require 'chronic_duration'

module RubyApp

  module Elements

    module Mobile

      module Inputs
        require 'ruby_app/elements/mobile/input'

        class DurationInput < RubyApp::Elements::Mobile::Input

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
              @duration = event.value ? ChronicDuration.parse(event.value) : nil
              @value = @duration ? ChronicDuration.output(@duration) : nil
              event.update_value("##{self.element_id}", @value)
              changed(event)
            end

        end

      end

    end

  end

end
