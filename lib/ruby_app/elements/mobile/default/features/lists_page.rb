module RubyApp

  module Elements

    module Mobile

      module Default

        module Features
          require 'ruby_app/elements/mobile/dialogs/acknowledgement_dialog'
          require 'ruby_app/elements/mobile/list'
          require 'ruby_app/elements/mobile/navigation/back_button'
          require 'ruby_app/elements/mobile/page'

          class ListsPage < RubyApp::Elements::Mobile::Page

            template_path(:all, File.dirname(__FILE__))

            def initialize
              super

              @back_button = RubyApp::Elements::Mobile::Navigation::BackButton.new

              @list = RubyApp::Elements::Mobile::List.new
              @list.attributes.merge!('data-filter'             => 'true',
                                      'data-filter-placeholder' => 'search')
              @list.search_value = 'default'
              @list.items += [  RubyApp::Elements::Mobile::List::ListDivider.new('List') ]
              @list.items += [  'Item 01',
                                'Item 02',
                                'Item 03' ].collect { |item| RubyApp::Elements::Mobile::List::ListItem.new(item) }

              item = RubyApp::Elements::Mobile::List::ListItem.new('Item 04')
              item.attributes.merge!('disabled' => true)
              @list.items += [ item ]

              @list.items += [  'Item 05',
                                'Item 06',
                                'Item 07' ].collect { |item| RubyApp::Elements::Mobile::List::ListSplitItem.new(item) }

              item = RubyApp::Elements::Mobile::List::ListSplitItem.new('Item 08')
              item.attributes.merge!('disabled' => true)
              @list.items += [ item ]

              @list.searched do |element, event|
                # RubyApp::Elements::Mobile::Dialog.show(event, RubyApp::Elements::Mobile::Dialogs::AcknowledgementDialog.new('List', "You input #{event.value}."))
                event.update_element(@list)
              end
              @list.item_clicked do |element, event|
                RubyApp::Elements::Mobile::Dialog.show(event, RubyApp::Elements::Mobile::Dialogs::AcknowledgementDialog.new('List', "You clicked the item #{event.item.item}."))
              end
              @list.link_clicked do |element, event|
                RubyApp::Elements::Mobile::Dialog.show(event, RubyApp::Elements::Mobile::Dialogs::AcknowledgementDialog.new('List', "You clicked the link #{event.item.item}."))
              end

            end

          end

        end

      end

    end

  end

end
