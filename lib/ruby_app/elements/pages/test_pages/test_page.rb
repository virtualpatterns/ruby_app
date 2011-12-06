module RubyApp

  module Elements

    module Pages

      module TestPages
        require 'ruby_app/elements/dialogs/exception_dialog'
        require 'ruby_app/elements/dialogs/message_dialog'
        require 'ruby_app/elements/input'
        require 'ruby_app/elements/markdown'
        require 'ruby_app/elements/pages/blank_page'
        require 'ruby_app/request'
        require 'ruby_app/session'

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
            self.unloaded do |element, event|
              event.update_text('li#unloaded', self.translate.unloaded(event.now))
            end

            @input = RubyApp::Elements::Input.new
            @input.changed do |element, event|
              event.set_cookie('_cookie', @input.value)
              RubyApp::Session.show(event, RubyApp::Elements::Dialogs::MessageDialog.new(self.translate.message_dialog.message.title,
                                                                                         self.translate.message_dialog.message.message(@input.value)))
            end

          end

        end

      end

    end

  end

end
