module RubyApp

  module Elements

    module Pages

      module TestPages
        require 'ruby_app'
        require 'ruby_app/elements'

        class TestPage < RubyApp::Elements::Pages::BlankPage

          template_path(:all, File.dirname(__FILE__))

          def initialize
            super

            self.interval = 2

            @markdown = RubyApp::Elements::Markdown.new

            self.loaded do |element, event|
              event.update_text('li#loaded', self.translate.loaded(event.now))
            end
            self.triggered do |element, event|
              event.update_text('li#triggered', self.translate.triggered(event.now))
            end

            @input = RubyApp::Elements::Input.new
            @input.changed do |element, event|
              event.set_cookie('_cookie', @input.value)
              RubyApp::Session.show_dialog(event, RubyApp::Elements::Dialogs::MessageDialog.new(self.translate.message_dialog.message.title,
                                                                                                self.translate.message_dialog.message.message(@input.value)))
            end

          end

        end

      end

    end

  end

end
