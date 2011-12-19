module RubyApp

  module Elements

    module Pages

      module Authentication

        module OpenID
          require 'ruby_app/elements/pages/authentication/open_id/authentication_page'
          require 'ruby_app/session'

          class EmailAuthenticationPage < RubyApp::Elements::Pages::Authentication::OpenID::AuthenticationPage

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