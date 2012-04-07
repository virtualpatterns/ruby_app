module RubyApp

  module Elements

    module Mobile

      module Pages

        module Information
          require 'ruby_app/elements/mobile/navigation/navigation_list'

          class InformationList < RubyApp::Elements::Mobile::Navigation::NavigationList

            template_path(:all, File.dirname(__FILE__))

            def initialize
              super
            end

          end

        end

      end

    end

  end

end
