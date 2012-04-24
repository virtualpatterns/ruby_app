module RubyApp

  module Elements

    module Mobile

      module Default

        module Features

          module Calendars
            require 'ruby_app'
            require 'ruby_app/elements/mobile/calendars/month'
            require 'ruby_app/elements/mobile/dialogs/acknowledgement_dialog'
            require 'ruby_app/elements/mobile/navigation/back_button'
            require 'ruby_app/elements/mobile/page'

            class MonthPage < RubyApp::Elements::Mobile::Page

              template_path(:all, File.dirname(__FILE__))

              def initialize
                super

                @back_button = RubyApp::Elements::Mobile::Navigation::BackButton.new

                @month = RubyApp::Elements::Mobile::Calendars::Month.new(Date.today, Date.today << 1)
                @month.changed do |element, event|
                  RubyApp::Elements::Mobile::Dialog.show(event, RubyApp::Elements::Mobile::Dialogs::AcknowledgementDialog.new('Month', "You selected day #{@month.value.day}."), :transition => 'pop')
                end

              end

            end

          end

        end

      end

    end

  end

end
