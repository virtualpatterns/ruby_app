module RubyApp

  module Elements

    module Mobile

      module Documents

        module Authentication

          module OAuth
            require 'ruby_app/elements/mobile/documents/authentication/o_auth/authentication_document'

            class EmailAuthenticationDocument < RubyApp::Elements::Mobile::Documents::Authentication::OAuth::AuthenticationDocument

              template_path(:all, File.dirname(__FILE__))

              def initialize(access_key, secret_key, scope, options)
                super(access_key, secret_key, scope, options)
              end

              def create_identity_from_email(email)
                return RubyApp::Session::Identity.new(email)
              end

            end

          end

        end

      end

    end

  end

end
