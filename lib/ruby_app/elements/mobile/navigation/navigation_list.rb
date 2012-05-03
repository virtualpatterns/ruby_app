module RubyApp

  module Elements

    module Mobile

      module Navigation
        require 'ruby_app/elements/mobile/list'
        require 'ruby_app/elements/mobile/navigation/navigation_link'

        class NavigationList < RubyApp::Elements::Mobile::List

          class NavigationListItem < RubyApp::Elements::Mobile::List::ListItem

            template_path(:all, File.dirname(__FILE__))

            def initialize(item)
              super(item)
              self.attributes.merge!('data-icon' => 'arrow-r')
            end

            def go(event, options)
            end

          end

          class NavigationListPageItem < RubyApp::Elements::Mobile::Navigation::NavigationList::NavigationListItem

            template_path(:all, File.dirname(__FILE__))

            alias :page :item

            def initialize(page)
              super(page)
            end

            def go(event, options)
              self.page.new.show(event, options)
            end

          end

          template_path(:all, File.dirname(__FILE__))

          attr_accessor :options

          def initialize
            super

            @options = RubyApp::Elements::Mobile::Navigation::NavigationLink.default_options

            self.item_clicked do |element, event|
              event.item.go(event, @options)
            end

          end

        end

      end

    end

  end

end
