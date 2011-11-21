module RubyApp

  module Elements

    module Lists
      require 'ruby_app/elements/list'

      class Select < RubyApp::Elements::List

        template_path(:all, File.dirname(__FILE__))

        exclude_parent_template(:html, :css, :js)

        attr_accessor :selected_item

        def initialize
          super
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
