module RubyApp

  module Elements

    module Mobile

      module Buttons
        require 'ruby_app/elements/mobile/button'

        class GitHubButton < RubyApp::Elements::Mobile::Button

          template_path(:all, File.dirname(__FILE__))

          def initialize
            super
            self.attributes.merge!('data-icon' => 'git-hub')
          end

        end

      end

    end

  end

end
