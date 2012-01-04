module RubyApp

  module Elements

    module Pages

      module TestPages
        require 'ruby_app/elements/dialogs/message_dialog'
        require 'ruby_app/elements/markdown'
        require 'ruby_app/elements/input'
        require 'ruby_app/elements/inputs/duration_input'
        require 'ruby_app/elements/pages/blank_page'
        require 'ruby_app/session'

        class InputTestPage < RubyApp::Elements::Pages::BlankPage

          template_path(:all, File.dirname(__FILE__))

          def initialize
            super

            @markdown = RubyApp::Elements::Markdown.new

            @input = RubyApp::Elements::Input.new
            @input.changed do |element, event|
              RubyApp::Session.show_dialog(event, RubyApp::Elements::Dialogs::MessageDialog.new(self.translate.message_dialog.message.title,
                                                                                                self.translate.message_dialog.message.message(@input.value || '(nil)')))
            end

            @duration_input = RubyApp::Elements::Inputs::DurationInput.new
            @duration_input.changed do |element, event|
              RubyApp::Session.show_dialog(event, RubyApp::Elements::Dialogs::MessageDialog.new(self.translate.message_dialog.message.title,
                                                                                                self.translate.message_dialog.message.message(@duration_input.duration || '(nil)')))
            end

          end

        end

      end

    end

  end

end
