module RubyApp

  module Elements

    module Mobile

      module Documents

        module Authentication

          module Facebook
            require 'ruby_app'
            require 'ruby_app/elements/mobile/documents/authentication/facebook/authentication_document'

            class EmailAuthenticationDocument < RubyApp::Elements::Mobile::Documents::Authentication::Facebook::AuthenticationDocument

              template_path(:all, File.dirname(__FILE__))

              def initialize
                super(['email'])
              end

              def create_identity_from_me(me)
                return self.create_identity_from_email(me['email'])
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
