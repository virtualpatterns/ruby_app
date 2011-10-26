module RubyApp

  module Elements

    module Dialogs

      module Calendars
        require 'ruby_app/elements/calendars/month'
        require 'ruby_app/elements/dialogs/blank_dialog'
        require 'ruby_app/elements/link'

        class MonthDialog < RubyApp::Elements::Dialogs::BlankDialog

          template_path(:all, File.dirname(__FILE__))

          def initialize(title, value = Date.today)
            super()

            attributes.merge!(:style => 'width: auto;')

            @title = title

            @month = RubyApp::Elements::Calendars::Month.new
            @month.display = value;
            @month.value = value;
            @month.changed do |element, event|
              @response = event.value
              event.hide(self)
            end

            @today = RubyApp::Elements::Link.new
            @today.clicked do |element, event|
              @response = Date.today
              event.hide(self)
            end

            @cancel = RubyApp::Elements::Link.new
            @cancel.clicked do |element, event|
              event.hide(self)
            end

          end

        end

      end

    end

  end

end
