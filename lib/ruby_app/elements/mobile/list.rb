require 'rubygems'
require 'bundler/setup'

require 'ruby-event'

module RubyApp

  module Elements

    module Mobile
      require 'ruby_app/element'

      class List < RubyApp::Element

        class ListItem < RubyApp::Element

          template_path(:all, File.dirname(__FILE__))

          attr_accessor :item

          def initialize(item)
            super()
            self.attributes.merge!('data-icon' => 'false')

            @item = item

          end

        end

        class ListDivider < RubyApp::Elements::Mobile::List::ListItem

          template_path(:all, File.dirname(__FILE__))

          exclude_parent_template(:html)

          def initialize(item)
            super(item)
            self.attributes.merge!('data-role' => 'list-divider')
          end

        end

        class ListSplitItem < RubyApp::Elements::Mobile::List::ListItem

          template_path(:all, File.dirname(__FILE__))

          exclude_parent_template(:html)

          def initialize(item)
            super(item)
          end

        end

        class ClickedEvent < RubyApp::Element::Event

          attr_reader :item

          def initialize(data)
            super(data)

            item = RubyApp::Element.get_element(data['item'])
            raise RubyApp::Exceptions::ElementInvalidException.new(data['item']) unless item
            @item = item

          end

          def to_hash
            super.merge('item' => @item.element_id)
          end

        end

        class ItemClickedEvent < RubyApp::Elements::Mobile::List::ClickedEvent

          def initialize(data)
            super(data)
          end

        end

        class LinkClickedEvent < RubyApp::Elements::Mobile::List::ClickedEvent

          def initialize(data)
            super(data)
          end

        end

        template_path(:all, File.dirname(__FILE__))

        attr_accessor :items

        event :item_clicked
        event :link_clicked

        def initialize
          super
          self.attributes.merge!('data-role' => 'listview')

          @items = []

        end

        protected

          def on_event(event)
            on_item_clicked(event) if event.is_a?(RubyApp::Elements::Mobile::List::ItemClickedEvent)
            on_link_clicked(event) if event.is_a?(RubyApp::Elements::Mobile::List::LinkClickedEvent)
            super(event)
          end

          def on_item_clicked(event)
            item_clicked(event)
          end

          def on_link_clicked(event)
            link_clicked(event)
          end

      end

    end

  end

end
