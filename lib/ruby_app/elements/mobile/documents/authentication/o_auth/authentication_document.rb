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
            require 'ruby_app/elements/mobile/document'

            class AuthenticationDocument < RubyApp::Elements::Mobile::Document

              template_path(:all, File.dirname(__FILE__))

              def initialize(access_key, secret_key, scopes, options)
                super()

                self.loaded do |element, event|

                  unless @client
                    RubyApp::Log.debug("OAUTH     scopes=#{scopes.inspect}")
                    RubyApp::Log.debug("OAUTH     options=#{options.inspect}")
                    @client = ::OAuth2::Client.new(access_key, secret_key, options)
                    url = @client.auth_code.authorize_url(:redirect_uri => RubyApp::Request.url,
                                                          :scope        => scopes.is_a?(Array) ? scopes.join(',') : scopes)
                    RubyApp::Log.debug("OAUTH     --> #{url.inspect}")
                    event.go(url)
                  else
                    RubyApp::Log.debug("OAUTH     <-- #{RubyApp::Request.url.inspect}")
                    code = RubyApp::Request.query['code']
                    access_token = @client.auth_code.get_token(code, :redirect_uri => RubyApp::Request.url)
                    RubyApp::Log.debug("OAUTH     token=#{access_token.token.inspect}")
                    RubyApp::Session.identity = self.create_identity_from_access_token(access_token)
                    RubyApp::Session.documents.pop
                    event.go('/')
                  end
                end

              end

            end

          end

        end

      end

    end

  end

end
