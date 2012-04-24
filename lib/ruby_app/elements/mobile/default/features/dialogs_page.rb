module RubyApp

  module Elements

    module Mobile

      module Default

        module Features
          require 'ruby_app/elements/mobile/button'
          require 'ruby_app/elements/mobile/dialog'
          require 'ruby_app/elements/mobile/dialogs/acknowledgement_dialog'
          require 'ruby_app/elements/mobile/dialogs/calendars/month_dialog'
          require 'ruby_app/elements/mobile/dialogs/confirmation_dialog'
          require 'ruby_app/elements/mobile/dialogs/exception_dialog'
          require 'ruby_app/elements/mobile/navigation/back_button'
          require 'ruby_app/elements/mobile/page'
          require 'ruby_app/exceptions'

          class DialogsPage < RubyApp::Elements::Mobile::Page

            template_path(:all, File.dirname(__FILE__))

            def initialize
              super

              @back_button = RubyApp::Elements::Mobile::Navigation::BackButton.new

              @acknowledgement_link = RubyApp::Elements::Mobile::Button.new
              @acknowledgement_link.clicked do |element, event|
                RubyApp::Elements::Mobile::Dialog.show(event, RubyApp::Elements::Mobile::Dialogs::AcknowledgementDialog.new('Acknowledgement', 'Acknowledge this.'), :transition => 'pop')
              end

              @confirmation_link = RubyApp::Elements::Mobile::Button.new
              @confirmation_link.clicked do |element, event|
                RubyApp::Elements::Mobile::Dialog.show(event, RubyApp::Elements::Mobile::Dialogs::ConfirmationDialog.new('Confirmation', 'Do you confirm this?'), :transition => 'pop') do |_event, response|
                  RubyApp::Elements::Mobile::Dialog.show(_event, RubyApp::Elements::Mobile::Dialogs::AcknowledgementDialog.new('Acknowledgement', "You responded #{response.inspect}."), :transition => 'pop')
                end
              end

              @exception_link = RubyApp::Elements::Mobile::Button.new
              @exception_link.clicked do |element, event|
                RubyApp::Elements::Mobile::Dialogs::ExceptionDialog.show_on_exception(event, :transition => 'pop') do
                  raise 'This is an exception.'
                end
              end

              @month_link = RubyApp::Elements::Mobile::Button.new
              @month_link.clicked do |element, event|
                RubyApp::Elements::Mobile::Dialog.show(event, RubyApp::Elements::Mobile::Dialogs::Calendars::MonthDialog.new(event.today, event.today << 1), :transition => 'pop') do |_event, response|
                  RubyApp::Elements::Mobile::Dialog.show(_event, RubyApp::Elements::Mobile::Dialogs::AcknowledgementDialog.new('Acknowledgement', "You responded day #{response.day}."), :transition => 'pop')
                end
              end

            end

          end

        end

      end

    end

  end

end
