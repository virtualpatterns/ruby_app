require 'rubygems'
require 'bundler/setup'

require 'oauth2'

module RubyApp

  module Elements

    module Mobile

      module Documents

        module Authentication

          module OAuth
            require 'ruby_app'
            require 'ruby_app/elements/mobile/documents/authentication/authentication_document'

            class AuthenticationDocument < RubyApp::Elements::Mobile::Documents::Authentication::AuthenticationDocument

              template_path(:all, File.dirname(__FILE__))

              def initialize(access_key, secret_key, scopes, options)
                super()

                self.page.loaded do |element, event|
                  unless @client
                    # RubyApp::Log.debug("OAUTH     scopes=#{scopes.inspect}")
                    # RubyApp::Log.debug("OAUTH     options=#{options.inspect}")
                    @client = ::OAuth2::Client.new(access_key, secret_key, options)
                    url = @client.auth_code.authorize_url(:redirect_uri => RubyApp::Request.environment[RubyApp::Elements::Mobile::Documents::Authentication::AuthenticationDocument.configuration.return_to],
                                                          :scope        => scopes.is_a?(Array) ? scopes.join(',') : scopes)
                    RubyApp::Log.info("OAUTH     --> #{url.inspect}")
                    event.go(url)
                  else
                    RubyApp::Log.info("OAUTH     <-- #{RubyApp::Request.url.inspect}")
                    code = RubyApp::Request.query['code']
                    access_token = @client.auth_code.get_token(code, :redirect_uri => RubyApp::Request.url)
                    # RubyApp::Log.debug("OAUTH     token=#{access_token.token.inspect}")
                    self.process_token(access_token)
                    self.hide(event)
                  end
                end

              end

              def process_token(token)
                RubyApp::Session.identity = self.create_identity_from_token(token)
              end

            end

          end

        end

      end

    end

  end

end
