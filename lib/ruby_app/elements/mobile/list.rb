require 'rubygems'
require 'bundler/setup'

require 'ruby-event'

module RubyApp

  module Elements

    module Mobile
      require 'ruby_app/element'

      class List < RubyApp::Element

        class ClickedEvent < RubyApp::Element::Event

          attr_reader :index, :item

          def initialize(data)
            super(data)
            @index = data['index'].to_i
            @item = self.source.items[@index]
          end

          def to_hash
            super.merge('index' => @index)
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
        attr_accessor :is_split

        event :item_clicked
        event :link_clicked

        def initialize
          super
          self.attributes.merge!('data-role' => 'listview')

          @items = []
          @is_split = false

        end

        def split?
          return self.is_split
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
