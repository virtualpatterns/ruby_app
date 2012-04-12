module RubyApp

  module Elements

    module Mobile

      module Documents

        module Authentication

          module OpenId
            require 'ruby_app/elements/mobile/documents/authentication/open_id/ax_authentication_document'

            class YahooAuthenticationDocument < RubyApp::Elements::Mobile::Documents::Authentication::OpenId::AxAuthenticationDocument

              template_path(:all, File.dirname(__FILE__))

              def initialize(identifier = RubyApp::Elements::Mobile::Documents::Authentication::OpenId::YahooAuthenticationDocument.configuration.identifier)
                super(identifier)
              end

              def process_request(request)
                ax_request = ::OpenID::AX::FetchRequest.new
                ax_request.add(::OpenID::AX::AttrInfo.new(RubyApp::Elements::Mobile::Documents::Authentication::OpenId::YahooAuthenticationDocument.configuration.attributes.email, 'Email', true))
                request.add_extension(ax_request)
              end

              def create_identity_from_response(response)
                ax_response = ::OpenID::AX::FetchResponse.from_success_response(response)
                if ax_response
                  self.create_identity_from_email(ax_response.data[RubyApp::Elements::Mobile::Documents::Authentication::OpenId::YahooAuthenticationDocument.configuration.attributes.email].first)
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

end
