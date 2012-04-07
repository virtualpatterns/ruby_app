module RubyApp

  module Elements

    module Mobile

      module Navigation
        require 'ruby_app/elements/mobile/navigation/navigation_button'

        class HideButton < RubyApp::Elements::Mobile::Navigation::NavigationButton

          template_path(:all, File.dirname(__FILE__))

          def initialize
            super

            self.options.merge!(:reverse => true)

            self.clicked do |element, event|
              RubyApp::Session.document.pages.last.hide(event, self.options)
            end

          end

        end

      end

    end

  end

end
