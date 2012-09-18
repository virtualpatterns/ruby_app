module RubyApp

  module Elements

    module Mobile

      module Buttons
        require 'ruby_app/elements/mobile/button'

        class YahooButton < RubyApp::Elements::Mobile::Button

          template_path(:all, File.dirname(__FILE__))

          def initialize
            super
            self.attributes.merge!('data-icon' => 'yahoo')
          end

        end

      end

    end

  end

end
