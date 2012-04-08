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
            require 'ruby_app/elements/mobile/document'

            class AuthenticationDocument < RubyApp::Elements::Mobile::Document

              template_path(:all, File.dirname(__FILE__))

              def initialize(identifier)
                super()

                self.loaded do |element, event|

                  unless @consumer
                    @consumer = ::OpenID::Consumer.new(RubyApp::Session.data, nil)
                    request = @consumer.begin(identifier)
                    self.process_request(request)
                    url = request.redirect_url(RubyApp::Request.url, RubyApp::Request.url)
                    RubyApp::Log.debug("OPENID --> #{url.inspect}")
                    event.go(url)
                  else
                    RubyApp::Log.debug("OPENID <-- #{RubyApp::Request.url.inspect}")
                    RubyApp::Request.query.each do |name, value|
                      RubyApp::Log.debug("OPENID #{name}=#{value}")
                    end
                    response = @consumer.complete(RubyApp::Request.query, RubyApp::Request.url)
                    case response.status
                      when ::OpenID::Consumer::SUCCESS
                        RubyApp::Session.identity = self.create_identity_from_response(response)
                      when ::OpenID::Consumer::FAILURE
                        RubyApp::Log.error("OPENID #{response.class}")
                        RubyApp::Log.error("OPENID #{response.message.inspect}")
                    end
                    RubyApp::Session.documents.pop
                    event.go('/')
                  end
                end

              end

              def process_request(request)
              end

              def create_identity_from_response(response)
                RubyApp::Session::Identity.new(response.identity_url)
              end

            end

          end

        end

      end

    end

  end

end
