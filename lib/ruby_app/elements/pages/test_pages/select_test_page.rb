module RubyApp

  module Elements

    module Pages

      module TestPages
        require 'ruby_app/elements/dialogs/message_dialog'
        require 'ruby_app/elements/markdown'
        require 'ruby_app/elements/pages/blank_page'
        require 'ruby_app/elements/lists/select'
        require 'ruby_app/session'

        class SelectTestPage < RubyApp::Elements::Pages::BlankPage

          template_path(:all, File.dirname(__FILE__))

          def initialize
            super

            @markdown = RubyApp::Elements::Markdown.new

            @select = RubyApp::Elements::Select.new
            @select.items += [ 'Item 01',
                               'Item 02',
                               'Item 03',
                               'Item 04',
                               'Item 05' ]
            @select.clicked do |element, event|
              RubyApp::Session.show_dialog(event, RubyApp::Elements::Dialogs::MessageDialog.new(self.translate.message_dialog.message.title,
                                                                                         self.translate.message_dialog.message.message(@select.selected_item)))
            end

          end

        end

      end

    end

  end

end
