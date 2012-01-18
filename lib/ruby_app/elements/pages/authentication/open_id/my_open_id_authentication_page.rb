module RubyApp

  module Elements

    module Pages

      module Authentication

        module OpenId
          require 'ruby_app/elements/pages/authentication/open_id/sreg_authentication_page'

          class MyOpenIdAuthenticationPage < RubyApp::Elements::Pages::Authentication::OpenId::SregAuthenticationPage

            template_path(:all, File.dirname(__FILE__))

            def initialize(identifier = self.configure.identifier)
              super(identifier)
            end

          end

        end

      end

    end

  end

end
