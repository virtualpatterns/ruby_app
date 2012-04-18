module RubyApp

  module Elements

    module Mobile

      module Pages

        module Information
          require 'ruby_app/elements/mobile/pages/information/information_list'

          class ScriptsList < RubyApp::Elements::Mobile::Pages::Information::InformationList

            class ScriptsListItem < RubyApp::Elements::Mobile::List::ListItem

              template_path(:all, File.dirname(__FILE__))

              alias :script :item

              def initialize(script)
                super(script)
              end

            end

            template_path(:all, File.dirname(__FILE__))

            def initialize
              super
              self.items = RubyApp::Session.get_scripts.collect { |script| RubyApp::Elements::Mobile::Pages::Information::ScriptsList::ScriptsListItem.new(script) }
            end

          end

        end

      end

    end

  end

end
