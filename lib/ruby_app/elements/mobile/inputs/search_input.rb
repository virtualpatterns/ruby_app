module RubyApp

  module Elements

    module Mobile

      module Inputs
        require 'ruby_app/elements/mobile/input'

        class SearchInput < RubyApp::Elements::Mobile::Input

          template_path(:all, File.dirname(__FILE__))

          def initialize
            super
            self.attributes.merge!('type' => 'search')
          end

        end

      end

    end

  end

end
