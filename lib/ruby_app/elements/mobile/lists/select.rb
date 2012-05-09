module RubyApp

  module Elements

    module Mobile

      module Lists
        require 'ruby_app/elements/mobile/list'

        class Select < RubyApp::Elements::Mobile::List

          template_path(:all, File.dirname(__FILE__))

          attr_accessor :selected_item

          def initialize
            super
            self.attributes.merge!('data-selected-theme' => 'b')
          end

          def selected_item=(item)
            @selected_item.attributes.merge!('data-theme' => nil) if @selected_item
            selected_items = self.items.select { |_item| _item.item == item }
            @selected_item = selected_items.first
            @selected_item.attributes.merge!('data-theme' => self.attributes['data-selected-theme']) if @selected_item
          end

          protected

            def on_item_clicked(event)
              @selected_item.attributes.merge!('data-theme' => nil) if @selected_item
              @selected_item = event.item
              @selected_item.attributes.merge!('data-theme' => self.attributes['data-selected-theme'])
              event.update_element(self)
              super(event)
            end

        end

      end

    end

  end

end
