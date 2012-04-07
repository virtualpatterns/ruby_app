module RubyApp

  module Elements

    module Mobile

      module Documents

        module Authentication

          module OpenId
            require 'ruby_app/elements/mobile/documents/authentication/open_id/ax_authentication_document'

            class GoogleAuthenticationDocument < RubyApp::Elements::Mobile::Documents::Authentication::OpenId::AxAuthenticationDocument

              template_path(:all, File.dirname(__FILE__))

              def initialize(identifier = self.configuration.identifier)
                super(identifier)
              end

            end

          end

        end

      end

    end

  end

end
