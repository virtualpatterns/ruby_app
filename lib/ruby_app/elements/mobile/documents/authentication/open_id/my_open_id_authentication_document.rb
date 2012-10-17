module RubyApp

  module Elements

    module Mobile

      module Documents

        module Authentication

          module OpenId
            require 'ruby_app/elements/mobile/documents/authentication/open_id/s_reg_authentication_document'

            class MyOpenIdAuthenticationDocument < RubyApp::Elements::Mobile::Documents::Authentication::OpenId::SRegAuthenticationDocument

              template_path(:all, File.dirname(__FILE__))

              def initialize(identifier = RubyApp::Elements::Mobile::Documents::Authentication::OpenId::MyOpenIdAuthenticationDocument.configuration.identifier)
                super(identifier)
              end

            end

          end

        end

      end

    end

  end

end
