module RubyApp

  module Elements

    module Pages

      module TestPages
        require 'ruby_app/elements/dialogs/message_dialog'
        require 'ruby_app/elements/markdown'
        require 'ruby_app/elements/pages/blank_page'
        require 'ruby_app/elements/list'
        require 'ruby_app/elements/lists/select'
        require 'ruby_app/session'

        class ListTestPage < RubyApp::Elements::Pages::BlankPage

          template_path(:all, File.dirname(__FILE__))

          def initialize
            super

            @markdown = RubyApp::Elements::Markdown.new

            @list = RubyApp::Elements::List.new
            @list.items += [ 'Item 01',
                             'Item 02',
                             'Item 03',
                             'Item 04',
                             'Item 05' ]
            @list.clicked do |element, event|
              RubyApp::Session.show(event, RubyApp::Elements::Dialogs::MessageDialog.new(self.translate.message_dialog.message.title,
                                                                                         self.translate.message_dialog.message.message(event.item)))
            end

            @select = RubyApp::Elements::Lists::Select.new
            @select.items += [ 'Item 11',
                               'Item 12',
                               'Item 13',
                               'Item 14',
                               'Item 15' ]
            @select.clicked do |element, event|
              RubyApp::Session.show(event, RubyApp::Elements::Dialogs::MessageDialog.new(self.translate.message_dialog.message.title,
                                                                                         self.translate.message_dialog.message.message(@select.selected_item)))
            end

          end

        end

      end

    end

  end

end
