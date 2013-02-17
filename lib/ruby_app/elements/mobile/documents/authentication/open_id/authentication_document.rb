require 'rubygems'
require 'bundler/setup'

require 'openid'

module RubyApp

  module Elements

    module Mobile

      module Documents

        module Authentication

          module OpenId
            require 'ruby_app'
            require 'ruby_app/elements/mobile/documents/authentication/authentication_document'

            class AuthenticationDocument < RubyApp::Elements::Mobile::Documents::Authentication::AuthenticationDocument

              template_path(:all, File.dirname(__FILE__))

              def initialize(identifier)
                super()

                self.page.loaded do |element, event|
                  unless @consumer
                    @consumer = ::OpenID::Consumer.new(RubyApp::Session.data, nil)
                    request = @consumer.begin(identifier)
                    self.process_request(request)
                    url = request.redirect_url(RubyApp::Request.environment[RubyApp::Elements::Mobile::Documents::Authentication::AuthenticationDocument.configuration.return_to], 
                                               RubyApp::Request.environment[RubyApp::Elements::Mobile::Documents::Authentication::AuthenticationDocument.configuration.return_to])
                    RubyApp::Log.debug("OPENID    --> #{url.inspect}")
                    event.go(url)
                  else
                    RubyApp::Log.debug("OPENID    <-- #{RubyApp::Request.url.inspect}")
                    response = @consumer.complete(RubyApp::Request.query, 
                                                  RubyApp::Request.environment[RubyApp::Elements::Mobile::Documents::Authentication::AuthenticationDocument.configuration.return_to])
                    case response.status
                      when ::OpenID::Consumer::SUCCESS
                        self.process_response(response)
                      when ::OpenID::Consumer::FAILURE
                        RubyApp::Log.error("OPENID    #{response.class}")
                        RubyApp::Log.error("OPENID    #{response.message.inspect}")
                        raise RubyApp::Exceptions::AuthenticationFailedException.new(response.message)
                    end
                    self.hide(event)
                  end
                end

              end

              def process_request(request)
              end

              def process_response(response)
                RubyApp::Session.identity = self.create_identity_from_response(response)
              end

              def create_identity_from_response(response)
                return RubyApp::Session::Identity.new(response.identity_url)
              end

            end

          end

        end

      end

    end

  end

end
