module RubyApp

  module Elements

    module Pages

      module TestPages
        require 'ruby_app'
        require 'ruby_app/elements'

        class DialogTestPage < RubyApp::Elements::Pages::BlankPage

          template_path(:all, File.dirname(__FILE__))

          def initialize
            super

            @markdown = RubyApp::Elements::Markdown.new
            @markdown.clicked do |element, event|
              case event.name
              when 'do_confirmation_dialog'
                RubyApp::Session.show_dialog(event, RubyApp::Elements::Dialogs::ConfirmationDialog.new(self.translate.confirmation_dialog.title,
                                                                                                       self.translate.confirmation_dialog.message)) do |_event, response|
                  RubyApp::Session.show_dialog(_event, RubyApp::Elements::Dialogs::MessageDialog.new(self.translate.confirmation_dialog.message_dialog.title,
                                                                                                     self.translate.confirmation_dialog.message_dialog.message(response)))
                end
              when 'do_exception_dialog'
                RubyApp::Elements::Dialogs::ExceptionDialog.show_dialog(event) do
                  raise self.translate.exception
                end
              when 'do_unhandled_exception_dialog'
                raise self.translate.exception
              when 'do_message_dialog'
                RubyApp::Session.show_dialog(event, RubyApp::Elements::Dialogs::MessageDialog.new(self.translate.message_dialog.message.title,
                                                                                                  self.translate.message_dialog.message.message))
              when 'do_month_dialog'
                RubyApp::Session.show_dialog(event, RubyApp::Elements::Dialogs::Calendars::MonthDialog.new(self.translate.month_dialog.title, event.today)) do |_event, response|
                  RubyApp::Session.show_dialog(_event, RubyApp::Elements::Dialogs::MessageDialog.new(self.translate.month_dialog.message_dialog.title,
                                                                                                     self.translate.month_dialog.message_dialog.message(response))) do |__event, _response|
                    __event.execute("$('#last_value').text('#{response}');")
                  end
                end
              when 'do_acknowledgement_dialog'
                RubyApp::Session.show_dialog(event, RubyApp::Elements::Dialogs::AcknowledgementDialog.new(self.translate.acknowledgement_dialog.title,
                                                                                                      self.translate.acknowledgement_dialog.message)) do |_event, response|
                  RubyApp::Session.show_dialog(_event, RubyApp::Elements::Dialogs::MessageDialog.new(self.translate.acknowledgement_dialog.message_dialog.title,
                                                                                                     self.translate.acknowledgement_dialog.message_dialog.message(response)))
                end
              end
            end

          end

        end

      end

    end

  end

end
