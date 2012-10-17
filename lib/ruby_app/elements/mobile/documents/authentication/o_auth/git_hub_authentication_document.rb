module RubyApp

  module Elements

    module Mobile

      module Documents

        module Authentication

          module OAuth
            require 'ruby_app/elements/mobile/documents/authentication/o_auth/authentication_document'

            class GitHubAuthenticationDocument < RubyApp::Elements::Mobile::Documents::Authentication::OAuth::AuthenticationDocument

              template_path(:all, File.dirname(__FILE__))

              def initialize(access_key = ENV['GITHUB_ACCESS_KEY'] || RubyApp::Elements::Mobile::Documents::Authentication::OAuth::GitHubAuthenticationDocument.configuration.access_key,
                             secret_key = ENV['GITHUB_SECRET_KEY'] || RubyApp::Elements::Mobile::Documents::Authentication::OAuth::GitHubAuthenticationDocument.configuration.secret_key,
                             scope      = [],
                             options    = {})
                _scope = ['user'] + scope
                _options = {:site           => RubyApp::Elements::Mobile::Documents::Authentication::OAuth::GitHubAuthenticationDocument.configuration.url,
                            :authorize_url  => RubyApp::Elements::Mobile::Documents::Authentication::OAuth::GitHubAuthenticationDocument.configuration.authorize_url,
                            :token_url      => RubyApp::Elements::Mobile::Documents::Authentication::OAuth::GitHubAuthenticationDocument.configuration.access_token_url}.merge(options)
                super(access_key, secret_key, _scope, _options)
              end

              def create_identity_from_access_token(access_token)
                user = JSON.parse(access_token.get('/user').body)
                RubyApp::Log.debug("GITHUB    user=#{user.inspect}")
                RubyApp::Session.identity = RubyApp::Session::Identity.new(user['email'])
              end

            end

          end

        end

      end

    end

  end

end
