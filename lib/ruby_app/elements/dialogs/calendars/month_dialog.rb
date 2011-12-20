module RubyApp

  module Elements

    module Dialogs

      module Calendars
        require 'ruby_app/elements/calendars/month'
        require 'ruby_app/elements/dialogs/blank_dialog'
        require 'ruby_app/elements/link'

        class MonthDialog < RubyApp::Elements::Dialogs::BlankDialog

          template_path(:all, File.dirname(__FILE__))

          def initialize(title, today = Date.today, display = nil, value = nil)
            super()

            attributes.merge!(:style => 'width: auto;')

            @title = title

            @month = RubyApp::Elements::Calendars::Month.new(today, display, value)
            @month.changed do |element, event|
              @response = event.value
              event.hide_dialog(self)
            end

            @today = RubyApp::Elements::Link.new
            @today.clicked do |element, event|
              @response = event.today
              event.hide_dialog(self)
            end

            @cancel = RubyApp::Elements::Link.new
            @cancel.clicked do |element, event|
              event.hide_dialog(self)
            end

          end

        end

      end

    end

  end

end
