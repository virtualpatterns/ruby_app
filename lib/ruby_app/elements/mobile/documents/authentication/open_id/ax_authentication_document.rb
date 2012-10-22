require 'rubygems'
require 'bundler/setup'

require 'openid/extensions/ax'

module RubyApp

  module Elements

    module Mobile

      module Documents

        module Authentication

          module OpenId
            require 'ruby_app'
            require 'ruby_app/elements/mobile/documents/authentication/open_id/email_authentication_document'

            class AxAuthenticationDocument < RubyApp::Elements::Mobile::Documents::Authentication::OpenId::EmailAuthenticationDocument

              template_path(:all, File.dirname(__FILE__))

              def initialize(identifier)
                super(identifier)
              end

              def process_request(request)
                ax_request = ::OpenID::AX::FetchRequest.new
                self.process_ax_request(ax_request)
                request.add_extension(ax_request)
              end

              def process_ax_request(ax_request)
                ax_request.add(::OpenID::AX::AttrInfo.new(RubyApp::Elements::Mobile::Documents::Authentication::OpenId::AxAuthenticationDocument.configuration.attributes.email, 'Email', true))
              end

              def create_identity_from_response(response)
                ax_response = ::OpenID::AX::FetchResponse.from_success_response(response)
                if ax_response
                  return self.create_identity_from_ax_response(ax_response)
                else
                  return super(response)
                end
              end

              def create_identity_from_ax_response(ax_response)
                return self.create_identity_from_email(ax_response.data[RubyApp::Elements::Mobile::Documents::Authentication::OpenId::AxAuthenticationDocument.configuration.attributes.email].first)
              end

            end

          end

        end

      end

    end

  end

end
