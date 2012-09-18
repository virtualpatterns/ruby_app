module RubyApp

  module Elements

    module Mobile

      module Buttons
        require 'ruby_app/elements/mobile/button'

        class FacebookButton < RubyApp::Elements::Mobile::Button

          template_path(:all, File.dirname(__FILE__))

          def initialize
            super
            self.attributes.merge!('data-icon' => 'facebook')
          end

        end

      end

    end

  end

end
