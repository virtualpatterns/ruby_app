module RubyApp

  module Elements

    module Mobile

      module Documents

        module Authentication
          require 'ruby_app/elements/mobile/documents/authentication/authentication_page'
          require 'ruby_app/elements/mobile/document'

          class AuthenticationDocument < RubyApp::Elements::Mobile::Document

            template_path(:all, File.dirname(__FILE__))

            def initialize
              super

              self.pages.push(RubyApp::Elements::Mobile::Documents::Authentication::AuthenticationPage.new)

            end

          end

        end

      end

    end

  end

end
