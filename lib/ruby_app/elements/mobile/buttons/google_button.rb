module RubyApp

  module Elements

    module Mobile

      module Buttons
        require 'ruby_app/elements/mobile/button'

        class GoogleButton < RubyApp::Elements::Mobile::Button

          template_path(:all, File.dirname(__FILE__))

          def initialize
            super
            self.attributes.merge!('data-icon' => 'google')
          end

        end

      end

    end

  end

end
