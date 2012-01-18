module RubyApp

  module Elements

    module Pages

      module Authentication

        module OpenId
          require 'ruby_app/elements/pages/authentication/open_id/base/base_authentication_page'

          class AuthenticationPage < RubyApp::Elements::Pages::Authentication::OpenId::Base::BaseAuthenticationPage

            template_path(:all, File.dirname(__FILE__))

            def initialize(identifier)
              super(identifier)
            end

          end

        end

      end

    end

  end

end
