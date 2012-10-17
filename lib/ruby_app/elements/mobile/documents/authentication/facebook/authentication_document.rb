require 'rubygems'
require 'bundler/setup'

require 'koala'

module RubyApp

  module Elements

    module Mobile

      module Documents

        module Authentication

          module Facebook
            require 'ruby_app'
            require 'ruby_app/elements/mobile/document'

            class AuthenticationDocument < RubyApp::Elements::Mobile::Document

              template_path(:all, File.dirname(__FILE__))

              def initialize(permissions)
                super()

                self.loaded do |element, event|

                  unless @authentication
                    RubyApp::Log.debug("FACEBOOK  permissions=#{permissions.inspect}")
                    @authentication = ::Koala::Facebook::OAuth.new(ENV['FACEBOOK_ACCESS_KEY'] || RubyApp::Elements::Mobile::Documents::Authentication::Facebook::AuthenticationDocument.configuration.access_key,
                                                                   ENV['FACEBOOK_SECRET_KEY'] || RubyApp::Elements::Mobile::Documents::Authentication::Facebook::AuthenticationDocument.configuration.secret_key,
                                                                   RubyApp::Request.url)
                    url = @authentication.url_for_oauth_code(:display => 'touch',
                                                             :permissions => permissions.is_a?(Array) ? permissions.join(',') : permissions)
                    RubyApp::Log.debug("FACEBOOK  --> #{url.inspect}")
                    event.go(url)
                  else
                    RubyApp::Log.debug("FACEBOOK  <-- #{RubyApp::Request.url.inspect}")
                    code = RubyApp::Request.query['code']
                    token = @authentication.get_access_token(code)
                    RubyApp::Log.debug("FACEBOOK  token=#{token.inspect}")
                    graph = ::Koala::Facebook::API.new(token)
                    me = graph.get_object('me')
                    RubyApp::Log.debug("FACEBOOK  me=#{me.inspect}")
                    RubyApp::Session.identity = self.create_identity_from_me(me)
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
