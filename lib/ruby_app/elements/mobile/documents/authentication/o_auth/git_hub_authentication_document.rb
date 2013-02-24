module RubyApp

  module Elements

    module Mobile

      module Documents

        module Authentication

          module OAuth
            require 'ruby_app/elements/mobile/documents/authentication/o_auth/email_authentication_document'

            class GitHubAuthenticationDocument < RubyApp::Elements::Mobile::Documents::Authentication::OAuth::EmailAuthenticationDocument

              template_path(:all, File.dirname(__FILE__))

              def initialize(access_key = ENV['GITHUB_ACCESS_KEY'] || RubyApp::Elements::Mobile::Documents::Authentication::OAuth::GitHubAuthenticationDocument.configuration.access_key,
                             secret_key = ENV['GITHUB_SECRET_KEY'] || RubyApp::Elements::Mobile::Documents::Authentication::OAuth::GitHubAuthenticationDocument.configuration.secret_key,
                             scopes      = [],
                             options    = {})
                _scopes = scopes.is_a?(Array) ? ( ['user'] + scopes ) : ( "user,#{scopes}")
                _options = {:site           => RubyApp::Elements::Mobile::Documents::Authentication::OAuth::GitHubAuthenticationDocument.configuration.url,
                            :authorize_url  => RubyApp::Elements::Mobile::Documents::Authentication::OAuth::GitHubAuthenticationDocument.configuration.authorize_url,
                            :token_url      => RubyApp::Elements::Mobile::Documents::Authentication::OAuth::GitHubAuthenticationDocument.configuration.access_token_url}.merge(options)
                super(access_key, secret_key, _scopes, _options)
              end

              def create_identity_from_token(token)
                user = JSON.parse(token.get('/user').body)
                # RubyApp::Log.debug("GITHUB    user=#{user.inspect}")
                return self.create_identity_from_email(user['email'])
              end

            end

          end

        end

      end

    end

  end

end
