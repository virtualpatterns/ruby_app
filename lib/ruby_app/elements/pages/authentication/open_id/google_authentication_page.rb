module RubyApp

  module Elements

    module Pages

      module Authentication

        module OpenId
          require 'ruby_app/elements/pages/authentication/open_id/ax_authentication_page'

          class GoogleAuthenticationPage < RubyApp::Elements::Pages::Authentication::OpenId::AxAuthenticationPage

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
