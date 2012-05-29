module RubyApp

  module Elements

    module Mobile

      module Navigation
        require 'ruby_app/elements/mobile/link'

        class NavigationLink < RubyApp::Elements::Mobile::Link

          template_path(:all, File.dirname(__FILE__))

          attr_accessor :options

          def initialize
            super
            @options = RubyApp::Elements::Mobile::Navigation::NavigationLink.default_options
          end

          def self.default_options
            return {:transition => 'none'}
          end

        end

      end

    end

  end

end
