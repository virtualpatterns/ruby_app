module RubyApp

  module Elements

    module Mobile

      module Default

        module Features
          require 'ruby_app/elements/mobile/dialogs/acknowledgement_dialog'
          require 'ruby_app/elements/mobile/list'
          require 'ruby_app/elements/mobile/lists/select'
          require 'ruby_app/elements/mobile/navigation/back_button'
          require 'ruby_app/elements/mobile/page'

          class ListsPage < RubyApp::Elements::Mobile::Page

            template_path(:all, File.dirname(__FILE__))

            def initialize
              super

              @back_button = RubyApp::Elements::Mobile::Navigation::BackButton.new

              @list = RubyApp::Elements::Mobile::List.new
              @list.attributes.merge!('data-inset' => true)
              @list.is_split = true
              @list.items += [  'Item 01',
                                'Item 02',
                                'Item 03',
                                'Item 04',
                                'Item 05' ]
              @list.item_clicked do |element, event|
                RubyApp::Elements::Mobile::Dialog.show(event, RubyApp::Elements::Mobile::Dialogs::AcknowledgementDialog.new('List', "You clicked the item #{event.item}."), :transition => 'pop')
              end
              @list.link_clicked do |element, event|
                RubyApp::Elements::Mobile::Dialog.show(event, RubyApp::Elements::Mobile::Dialogs::AcknowledgementDialog.new('List', "You clicked the link #{event.item}."), :transition => 'pop')
              end

              @select = RubyApp::Elements::Mobile::Lists::Select.new
              @select.attributes.merge!('data-inset' => true)
              @select.is_split = true
              @select.items += [  'Item 11',
                                  'Item 12',
                                  'Item 13',
                                  'Item 14',
                                  'Item 15' ]
              @select.item_clicked do |element, event|
                RubyApp::Elements::Mobile::Dialog.show(event, RubyApp::Elements::Mobile::Dialogs::AcknowledgementDialog.new('List', "You clicked the item #{event.item}."), :transition => 'pop')
              end
              @select.link_clicked do |element, event|
                RubyApp::Elements::Mobile::Dialog.show(event, RubyApp::Elements::Mobile::Dialogs::AcknowledgementDialog.new('List', "You clicked the link #{event.item}."), :transition => 'pop')
              end

            end

          end

        end

      end

    end

  end

end
