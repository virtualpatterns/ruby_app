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
                    RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} url=#{url.inspect}")
                    event.go(url)
                  else
                    RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} RubyApp::Request.query=#{RubyApp::Request.query.inspect}")
                    RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} RubyApp::Request.url=#{RubyApp::Request.url.inspect}")
                    response = @consumer.complete(RubyApp::Request.query, RubyApp::Request.url)
                    case response.status
                      when ::OpenID::Consumer::SUCCESS
                        RubyApp::Session.identity = self.create_identity_from_response(response)
                        RubyApp::Session.documents.pop
                        event.go('/')
                      when ::OpenID::Consumer::FAILURE
                        RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} response.class=#{response.class}")
                        RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} response.message=#{response.message.inspect}")
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
