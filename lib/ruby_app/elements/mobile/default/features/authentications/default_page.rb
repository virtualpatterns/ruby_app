module RubyApp

  module Elements

    module Mobile

      module Default

        module Features

          module Authentications
            require 'ruby_app'
            require 'ruby_app/elements/mobile/button'
            require 'ruby_app/elements/mobile/documents/authentication/facebook/email_authentication_document'
            require 'ruby_app/elements/mobile/documents/authentication/null/authentication_document'
            require 'ruby_app/elements/mobile/documents/authentication/o_auth/git_hub_authentication_document'
            require 'ruby_app/elements/mobile/documents/authentication/open_id/google_authentication_document'
            require 'ruby_app/elements/mobile/documents/authentication/open_id/my_open_id_authentication_document'
            require 'ruby_app/elements/mobile/documents/authentication/open_id/yahoo_authentication_document'
            require 'ruby_app/elements/mobile/navigation/back_button'
            require 'ruby_app/elements/mobile/page'

            class DefaultPage < RubyApp::Elements::Mobile::Page

              template_path(:all, File.dirname(__FILE__))

              def initialize
                super

                @back_button = RubyApp::Elements::Mobile::Navigation::BackButton.new

                @github_authentication_link = RubyApp::Elements::Mobile::Button.new
                @github_authentication_link.clicked do |element, event|
                  RubyApp::Elements::Mobile::Documents::Authentication::OAuth::GitHubAuthenticationDocument.new.show(event)
                end

                @facebook_authentication_link = RubyApp::Elements::Mobile::Button.new
                @facebook_authentication_link.clicked do |element, event|
                  RubyApp::Elements::Mobile::Documents::Authentication::Facebook::EmailAuthenticationDocument.new.show(event)
                end

                @google_authentication_link = RubyApp::Elements::Mobile::Button.new
                @google_authentication_link.clicked do |element, event|
                  RubyApp::Elements::Mobile::Documents::Authentication::OpenId::GoogleAuthenticationDocument.new.show(event)
                end

                @my_open_id_authentication_link = RubyApp::Elements::Mobile::Button.new
                @my_open_id_authentication_link.clicked do |element, event|
                  RubyApp::Elements::Mobile::Documents::Authentication::OpenId::MyOpenIdAuthenticationDocument.new.show(event)
                end

                @yahoo_authentication_link = RubyApp::Elements::Mobile::Button.new
                @yahoo_authentication_link.clicked do |element, event|
                  RubyApp::Elements::Mobile::Documents::Authentication::OpenId::YahooAuthenticationDocument.new.show(event)
                end

                @null_authentication_link = RubyApp::Elements::Mobile::Button.new
                @null_authentication_link.clicked do |element, event|
                  RubyApp::Elements::Mobile::Documents::Authentication::Null::AuthenticationDocument.new.show(event)
                end

              end

            end

          end

        end

      end

    end

  end

end
