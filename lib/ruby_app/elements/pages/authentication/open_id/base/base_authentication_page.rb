require 'rubygems'
require 'bundler/setup'

require 'openid'

module RubyApp

  module Elements

    module Pages

      module Authentication

        module OpenId

          module Base
            require 'ruby_app/elements/page'
            require 'ruby_app/log'
            require 'ruby_app/request'
            require 'ruby_app/session'

            class BaseAuthenticationPage < RubyApp::Elements::Page

              template_path(:all, File.dirname(__FILE__))

              def initialize(identifier)
                super()

                self.loaded do |element, event|

                  unless @consumer
                    @consumer = ::OpenID::Consumer.new(RubyApp::Session.data, nil)
                    request = @consumer.begin(identifier)
                    self.process_request(request)
                    event.go(request.redirect_url(RubyApp::Request.url, RubyApp::Request.url))
                  else
                    response = @consumer.complete(RubyApp::Request.query, RubyApp::Request.url)
                    case response.status
                      when ::OpenID::Consumer::SUCCESS
                        RubyApp::Session.identity = self.create_identity_from_response(response)
                        RubyApp::Session.pages.pop
                        event.go('/')
                      when ::OpenID::Consumer::CANCEL
                        RubyApp::Session.pages.pop
                        event.go('/')
                      when ::OpenID::Consumer::FAILURE
                        RubyApp::Log.debug("#{self.class}#loaded response=#{response.inspect}")
                    end
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
