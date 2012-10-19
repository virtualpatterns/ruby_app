module RubyApp

  module Elements

    module Mobile

      module Pages
        require 'ruby_app/elements/mobile/navigation/navigation_list'

        class ScriptsList < RubyApp::Elements::Mobile::Navigation::NavigationList

          class ScriptsListItem < RubyApp::Elements::Mobile::Navigation::NavigationList::NavigationListItem

            template_path(:all, File.dirname(__FILE__))

            alias :script :item

            def initialize(script)
              super(script)
            end

          end

          template_path(:all, File.dirname(__FILE__))

          def initialize
            super
            self.items = RubyApp::Session.get_scripts.collect { |script| RubyApp::Elements::Mobile::Pages::ScriptsList::ScriptsListItem.new(script) }
          end

        end

      end

    end

  end

end
