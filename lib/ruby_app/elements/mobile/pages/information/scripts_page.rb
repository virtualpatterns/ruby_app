module RubyApp

  module Elements

    module Mobile

      module Pages

        module Information
          require 'ruby_app/elements/mobile/navigation/back_button'
          require 'ruby_app/elements/mobile/pages/information/scripts_list'
          require 'ruby_app/elements/mobile/page'

          class ScriptsPage < RubyApp::Elements::Mobile::Page

            template_path(:all, File.dirname(__FILE__))

            def initialize
              super

              @back_button = RubyApp::Elements::Mobile::Navigation::BackButton.new

              @scripts_list = RubyApp::Elements::Mobile::Pages::Information::ScriptsList.new
              @scripts_list.clicked do |element, event|
                event.go(event.item.url)
              end

            end

          end

        end

      end

    end

  end

end
