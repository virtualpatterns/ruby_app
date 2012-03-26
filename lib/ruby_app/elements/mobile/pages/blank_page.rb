module RubyApp

  module Elements

    module Mobile

      module Pages
        require 'ruby_app/elements/mobile/page'

        class BlankPage < RubyApp::Elements::Mobile::Page

          template_path(:all, File.dirname(__FILE__))

          def initialize
            super
          end

        end

      end

    end

  end

end
