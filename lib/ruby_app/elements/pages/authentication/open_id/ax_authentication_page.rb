require 'rubygems'
require 'bundler/setup'

require 'openid/extensions/ax'

module RubyApp

  module Elements

    module Pages

      module Authentication

        module OpenId
          require 'ruby_app'
          require 'ruby_app/elements/pages/authentication/open_id/email_authentication_page'

          class AxAuthenticationPage < RubyApp::Elements::Pages::Authentication::OpenId::EmailAuthenticationPage

            template_path(:all, File.dirname(__FILE__))

            def initialize(identifier)
              super(identifier)
            end

            def process_request(request)
              ax_request = ::OpenID::AX::FetchRequest.new
              ax_request.add(::OpenID::AX::AttrInfo.new(self.configuration.attributes.email, 'Email', true))
              request.add_extension(ax_request)
            end

            def create_identity_from_response(response)
              ax_response = ::OpenID::AX::FetchResponse.from_success_response(response)
              if ax_response
                self.create_identity_from_email(ax_response.data[self.configuration.attributes.email].first)
              else
                super(response)
              end
            end

          end

        end

      end

    end

  end

end
