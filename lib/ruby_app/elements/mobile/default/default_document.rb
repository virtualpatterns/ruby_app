module RubyApp

  module Elements

    module Mobile

      module Default
        require 'ruby_app/elements/mobile/default/default_page'
        require 'ruby_app/elements/mobile/platforms/ios/document'

        class DefaultDocument < RubyApp::Elements::Mobile::Platforms::Ios::Document

          template_path(:all, File.dirname(__FILE__))

          def initialize
            super

            self.pages.push(RubyApp::Elements::Mobile::Default::DefaultPage.new)

          end

        end

      end

    end

  end

end
