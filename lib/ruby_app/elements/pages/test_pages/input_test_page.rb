module RubyApp

  module Elements

    module Pages

      module TestPages
        require 'ruby_app'
        require 'ruby_app/elements'

        class InputTestPage < RubyApp::Elements::Pages::BlankPage

          template_path(:all, File.dirname(__FILE__))

          def initialize
            super

            @markdown = RubyApp::Elements::Markdown.new

            @input = RubyApp::Elements::Input.new
            @input.changed do |element, event|
              RubyApp::Session.show_dialog(event, RubyApp::Elements::Dialogs::MessageDialog.new(self.translate.message_dialog.message.title,
                                                                                                self.translate.message_dialog.message.message(@input.value || '(nil)', @input.value.class)))
            end

            @duration_input = RubyApp::Elements::Inputs::DurationInput.new
            @duration_input.changed do |element, event|
              RubyApp::Session.show_dialog(event, RubyApp::Elements::Dialogs::MessageDialog.new(self.translate.message_dialog.message.title,
                                                                                                self.translate.message_dialog.message.message(@duration_input.duration || '(nil)', @duration_input.value.class)))
            end

            @multiline_input = RubyApp::Elements::Inputs::MultilineInput.new
            @multiline_input.changed do |element, event|
              RubyApp::Session.show_dialog(event, RubyApp::Elements::Dialogs::MessageDialog.new(self.translate.message_dialog.message.title,
                                                                                                self.translate.message_dialog.message.message(@multiline_input.value || '(nil)', @multiline_input.value.class)))
            end

            @email_input = RubyApp::Elements::Inputs::EmailInput.new
            @email_input.changed do |element, event|
              RubyApp::Session.show_dialog(event, RubyApp::Elements::Dialogs::MessageDialog.new(self.translate.message_dialog.message.title,
                                                                                                self.translate.message_dialog.message.message(@email_input.value || '(nil)', @email_input.value.class)))
            end

            @toggle_input = RubyApp::Elements::Inputs::ToggleInput.new
            @toggle_input.changed do |element, event|
              RubyApp::Session.show_dialog(event, RubyApp::Elements::Dialogs::MessageDialog.new(self.translate.message_dialog.message.title,
                                                                                                self.translate.message_dialog.message.message(@toggle_input.value, @toggle_input.value.class)))
            end

          end

        end

      end

    end

  end

end
