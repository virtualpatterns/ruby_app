module RubyApp

  module Elements

    module Mobile

      module Pages

        module Information
          require 'ruby_app/elements/mobile/pages/information/information_list'

          class ScriptsList < RubyApp::Elements::Mobile::Pages::Information::InformationList

            template_path(:all, File.dirname(__FILE__))

            def initialize
              super
              self.items = RubyApp::Session.get_scripts
            end

          end

        end

      end

    end

  end

end
