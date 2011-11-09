require 'rubygems'
require 'bundler/setup'

require 'openid'

module RubyApp

  module Elements

    module Pages

      module Authentication

        module OpenID
          require 'ruby_app/elements/page'
          require 'ruby_app/log'
          require 'ruby_app/request'
          require 'ruby_app/session'

          class AuthenticationPage < RubyApp::Elements::Page

            template_path(:all, File.dirname(__FILE__))

            def initialize(identifier)
              super()

              self.loaded do |element, event|
                RubyApp::Session.show(event, RubyApp::Elements::Dialogs::BusyDialog.new(RubyApp::Elements::Pages::Authentication::OpenID::AuthenticationPage.translate.busy_dialog.message)) do |_event|
                  if RubyApp::Request.query.empty?
                    @consumer = ::OpenID::Consumer.new(RubyApp::Session.data, nil)
                    RubyApp::Log.debug("#{self.class}#loaded identifier=#{identifier.inspect}")
                    request = @consumer.begin(identifier)
                    self.process_request(request)
                    _event.go(request.redirect_url(RubyApp::Request.url, RubyApp::Request.url))
                  else
                    response = @consumer.complete(RubyApp::Request.query, RubyApp::Request.url)
                    RubyApp::Log.debug("#{self.class}#loaded response.class=#{response.class}")
                    case response.status
                      when ::OpenID::Consumer::SUCCESS
                        RubyApp::Log.debug("#{self.class}#loaded response.identity_url=#{response.identity_url.inspect}")
                        RubyApp::Session.identity = self.create_identity_from_response(response)
                        RubyApp::Session.pages.pop
                        _event.refresh
                      when ::OpenID::Consumer::CANCEL
                        RubyApp::Session.pages.pop
                        _event.refresh
                      when ::OpenID::Consumer::FAILURE
                        RubyApp::Log.debug("#{self.class}#loaded response=#{response.inspect}")
                    end
                  end
                end
              end

            end

            def process_request(request)
            end

            def create_identity_from_response(response)
              self.create_identity_from_url(response.identity_url)
            end

            def create_identity_from_url(url, data = {})
              RubyApp::Session::Identity.new(url, data)
            end

          end

        end

      end

    end

  end

end
