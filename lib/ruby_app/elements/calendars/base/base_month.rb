require 'rubygems'
require 'bundler/setup'

require 'ruby-event'

module RubyApp

  module Elements

    module Calendars

      module Base
        require 'ruby_app/element'

        class BaseMonth < RubyApp::Element

          class MovedEvent < RubyApp::Element::Event

            attr_reader :unit, :amount

            def initialize(data)
              super(data)
              @unit = data['unit'].to_sym
              @amount = data['amount'].to_i
            end

            def to_hash
              super.merge('unit' => @name, 'amount' => @amount)
            end

          end

          class ChangedEvent < RubyApp::Element::Event

            attr_reader :value

            def initialize(data)
              super(data)
              @value = Date.parse(data['date'])
            end

            def to_hash
              super.merge('value' => @value.strftime)
            end

          end

          template_path(:all, File.dirname(__FILE__))

          attr_accessor :today, :display, :value

          event :changed

          def initialize(today = Date.today, display = nil, value = nil)
            super()
            @today = today
            @display = display || today
            @value = value || today
          end

          def display_first_date
            first_of_month = @display - (@display.day - 1)
            first_of_month - first_of_month.wday
          end

          def display_last_date
            next_month = @display >> 1
            last_of_month = next_month - next_month.day
            last_of_month + (6 - last_of_month.wday)
          end

          protected

            def on_event(event)
              on_moved(event) if event.is_a?(RubyApp::Elements::Calendars::Month::MovedEvent)
              on_changed(event) if event.is_a?(RubyApp::Elements::Calendars::Month::ChangedEvent)
              super(event)
            end

            def on_moved(event)
              case event.unit
                when :month
                  @display = @display >> event.amount
                  event.update_element(self)
              end
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
