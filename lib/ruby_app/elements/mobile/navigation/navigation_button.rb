module RubyApp

  module Elements

    module Mobile

      module Navigation
        require 'ruby_app/elements/mobile/button'
        require 'ruby_app/elements/mobile/navigation/navigation_link'

        class NavigationButton < RubyApp::Elements::Mobile::Button

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
