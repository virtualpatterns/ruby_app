module RubyApp

  module Elements

    module Mobile

      module Documents

        module Authentication

          module OpenId
            require 'ruby_app'
            require 'ruby_app/elements/mobile/documents/authentication/open_id/authentication_document'

            class EmailAuthenticationDocument < RubyApp::Elements::Mobile::Documents::Authentication::OpenId::AuthenticationDocument

              template_path(:all, File.dirname(__FILE__))

              def initialize(identifier)
                super(identifier)
              end

              def create_identity_from_email(email)
                RubyApp::Session::Identity.new(email)
              end

            end

          end

        end

      end

    end

  end

end
