module RubyApp

  module Elements

    module Mobile

      module Lists
        require 'ruby_app/elements/mobile/list'

        class Select < RubyApp::Elements::Mobile::List

          template_path(:all, File.dirname(__FILE__))

          exclude_parent_template(:html)

          attr_accessor :selected_item

          def initialize
            super
            self.attributes.merge!('data-selected-theme' => 'a')
          end

          def selected_item=(item)
            @selected_item = item
          end

          protected

            def on_clicked(event)
              @selected_item = event.item
              event.update_element(self)
              super(event)
            end

        end

      end

    end

  end

end
