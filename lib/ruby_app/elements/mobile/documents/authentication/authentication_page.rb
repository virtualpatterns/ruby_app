module RubyApp

  module Elements

    module Mobile

      module Documents

        module Authentication
          require 'ruby_app/elements/mobile/navigation/close_button'
          require 'ruby_app/elements/mobile/page'

          class AuthenticationPage < RubyApp::Elements::Mobile::Page

            template_path(:all, File.dirname(__FILE__))

            def initialize
              super

              @close_button = RubyApp::Elements::Mobile::Navigation::CloseButton.new
              @close_button.attributes.merge!('class' => 'ui-btn-right')

            end

          end

        end

      end

    end

  end

end
