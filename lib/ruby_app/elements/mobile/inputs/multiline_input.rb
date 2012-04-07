module RubyApp

  module Elements

    module Mobile

      module Inputs
        require 'ruby_app/elements/mobile/input'

        class MultilineInput < RubyApp::Elements::Mobile::Input

          template_path(:all, File.dirname(__FILE__))

          exclude_parent_template(:html, :js)

          def initialize
            super
          end

        end

      end

    end

  end

end
