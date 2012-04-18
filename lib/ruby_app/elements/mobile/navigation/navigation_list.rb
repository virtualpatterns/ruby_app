module RubyApp

  module Elements

    module Mobile

      module Navigation
        require 'ruby_app/elements/mobile/list'
        require 'ruby_app/elements/mobile/navigation/navigation_link'

        class NavigationList < RubyApp::Elements::Mobile::List

          class NavigationListItem < RubyApp::Elements::Mobile::List::ListItem

            template_path(:all, File.dirname(__FILE__))

            def initialize(script)
              super(script)
              self.attributes.merge!('data-icon' => 'arrow-r')
            end

          end

          template_path(:all, File.dirname(__FILE__))

          attr_accessor :options

          def initialize
            super
            @options = RubyApp::Elements::Mobile::Navigation::NavigationLink.default_options
          end

        end

      end

    end

  end

end
