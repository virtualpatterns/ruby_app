module RubyApp

  module Elements

    module Pages

      module TestPages
        require 'ruby_app/elements/markdown'
        require 'ruby_app/elements/dialogs/busy_dialog'
        require 'ruby_app/elements/dialogs/calendars/month_dialog'
        require 'ruby_app/elements/dialogs/confirmation_dialog'
        require 'ruby_app/elements/dialogs/exception_dialog'
        require 'ruby_app/elements/dialogs/message_dialog'
        require 'ruby_app/elements/pages/blank_page'
        require 'ruby_app/session'

        class DialogTestPage < RubyApp::Elements::Pages::BlankPage

          template_path(:all, File.dirname(__FILE__))

          def initialize
            super

            @markdown = RubyApp::Elements::Markdown.new
            @markdown.navigated do |element, event|
              case event.name
              when 'do_busy_dialog'
                RubyApp::Session.show(event, RubyApp::Elements::Dialogs::BusyDialog.new(self.translate.busy_dialog.message)) do |_event|
                  sleep 30
                end
              when 'do_confirmation_dialog'
                RubyApp::Session.show(event, RubyApp::Elements::Dialogs::ConfirmationDialog.new(self.translate.confirmation_dialog.title,
                                                                                                self.translate.confirmation_dialog.message)) do |_event, response|
                  RubyApp::Session.show(_event, RubyApp::Elements::Dialogs::MessageDialog.new(self.translate.confirmation_dialog.message_dialog.title,
                                                                                              self.translate.confirmation_dialog.message_dialog.message(response)))
                end
              when 'do_exception_dialog'
                begin
                  raise self.translate.exception
                rescue Exception => exception
                  RubyApp::Session.show(event, RubyApp::Elements::Dialogs::ExceptionDialog.new(exception))
                end
              when 'do_message_dialog'
                RubyApp::Session.show(event, RubyApp::Elements::Dialogs::MessageDialog.new(self.translate.message_dialog.message.title,
                                                                                           self.translate.message_dialog.message.message))
              when 'do_month_dialog'
                RubyApp::Session.show(event, RubyApp::Elements::Dialogs::Calendars::MonthDialog.new(self.translate.month_dialog.title)) do |_event, response|
                  RubyApp::Session.show(_event, RubyApp::Elements::Dialogs::MessageDialog.new(self.translate.month_dialog.message_dialog.title,
                                                                                              self.translate.month_dialog.message_dialog.message(response))) do |__event, _response|
                    __event.execute("$('#last_value').text('#{response}');")
                  end
                end
              end
            end

          end

        end

      end

    end

  end

end
