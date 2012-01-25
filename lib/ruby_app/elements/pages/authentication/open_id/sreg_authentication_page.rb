require 'rubygems'
require 'bundler/setup'

require 'openid/extensions/sreg'

module RubyApp

  module Elements

    module Pages

      module Authentication

        module OpenId
          require 'ruby_app/elements/pages/authentication/open_id/email_authentication_page'
          require 'ruby_app/session'

          class SregAuthenticationPage < RubyApp::Elements::Pages::Authentication::OpenId::EmailAuthenticationPage

            template_path(:all, File.dirname(__FILE__))

            def initialize(identifier)
              super(identifier)
            end

            def process_request(request)
              sreg_request = ::OpenID::SReg::Request.new
              sreg_request.request_fields(['email'], true)
              request.add_extension(sreg_request)
            end

            def create_identity_from_response(response)
              sreg_response = ::OpenID::SReg::Response.from_success_response(response)
              unless sreg_response.empty?
                self.create_identity_from_email(sreg_response.data['email'])
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
