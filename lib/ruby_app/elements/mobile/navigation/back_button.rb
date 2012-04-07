module RubyApp

  module Elements

    module Mobile

      module Navigation
        require 'ruby_app/elements/mobile/navigation/hide_button'

        class BackButton < RubyApp::Elements::Mobile::Navigation::HideButton

          template_path(:all, File.dirname(__FILE__))

          def initialize
            super
          end

        end

      end

    end

  end

end
