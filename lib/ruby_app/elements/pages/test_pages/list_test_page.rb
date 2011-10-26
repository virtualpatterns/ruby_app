module RubyApp

  module Elements

    module Pages

      module TestPages
        require 'ruby_app/elements/dialogs/message_dialog'
        require 'ruby_app/elements/pages/blank_page'
        require 'ruby_app/elements/list'
        require 'ruby_app/elements/lists/select'
        require 'ruby_app/session'

        class ListTestPage < RubyApp::Elements::Pages::BlankPage

          template_path(:all, File.dirname(__FILE__))

          def initialize
            super

            @list = RubyApp::Elements::List.new
            @list.selected do |element, event|
              RubyApp::Session.show(event, RubyApp::Elements::Dialogs::MessageDialog.new(self.translate.message_dialog.message.title,
                                                                                         self.translate.message_dialog.message.message(event.item)))
            end

            @list.items += [ 'Item 01',
                             'Item 02',
                             'Item 03' ]

            @select = RubyApp::Elements::Lists::Select.new
            @select.selected do |element, event|
              RubyApp::Session.show(event, RubyApp::Elements::Dialogs::MessageDialog.new(self.translate.message_dialog.message.title,
                                                                                         self.translate.message_dialog.message.message(event.item)))
            end

            @select.items += [ 'Item 04',
                               'Item 05',
                               'Item 06' ]

          end

        end

      end

    end

  end

end
