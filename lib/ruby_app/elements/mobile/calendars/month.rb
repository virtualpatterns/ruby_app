require 'rubygems'
require 'bundler/setup'

require 'ruby-event'

module RubyApp

  module Elements

    module Mobile

      module Calendars
        require 'ruby_app/element'

        class Month < RubyApp::Element

          class ChangedEvent < RubyApp::Element::Event

            attr_reader :value

            def initialize(data)
              super(data)
              @value = data['value'].strip
              @value = @value.empty? ? nil : Date.parse(@value)
            end

            def to_hash
              super.merge(:value => @value)
            end

          end

          template_path(:all, File.dirname(__FILE__))

          attr_accessor :value
          attr_accessor :display

          event :changed

          def initialize(today = Date.today, value = Date.today)
            super()
            @today = today
            @value = value
            @display = @value
          end

          def move_previous(event)
            @display = @display << 1
            event.update_element(self)
          end

          def move_next(event)
            @display = @display >> 1
            event.update_element(self)
          end

          protected

            def first_date
              first_of_month = @display - (@display.day - 1)
              return first_of_month - first_of_month.wday
            end

            def last_date
              next_month = @display >> 1
              last_of_month = next_month - next_month.day
              return last_of_month + (6 - last_of_month.wday)
            end

            def on_event(event)
              on_changed(event) if event.is_a?(RubyApp::Elements::Mobile::Calendars::Month::ChangedEvent)
              super(event)
            end

            def on_changed(event)
              @value = event.value
              event.update_element(self)
              changed(event)
            end

        end

      end

    end

  end

end
