module RubyApp

  module Elements

    module Mobile

      module Default

        module Features

          module Authentications
            require 'ruby_app'
            require 'ruby_app/elements/mobile/buttons/facebook_button'
            require 'ruby_app/elements/mobile/buttons/git_hub_button'
            require 'ruby_app/elements/mobile/buttons/google_button'
            require 'ruby_app/elements/mobile/buttons/my_open_id_button'
            require 'ruby_app/elements/mobile/buttons/yahoo_button'
            require 'ruby_app/elements/mobile/documents/authentication/facebook/email_authentication_document'
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

                @github_authentication_link = RubyApp::Elements::Mobile::Buttons::GitHubButton.new
                @github_authentication_link.clicked do |element, event|
                  RubyApp::Session.documents.push(RubyApp::Elements::Mobile::Documents::Authentication::OAuth::GitHubAuthenticationDocument.new)
                  event.refresh_browser
                end

                @facebook_authentication_link = RubyApp::Elements::Mobile::Buttons::FacebookButton.new
                @facebook_authentication_link.clicked do |element, event|
                  RubyApp::Session.documents.push(RubyApp::Elements::Mobile::Documents::Authentication::Facebook::EmailAuthenticationDocument.new)
                  event.refresh_browser
                end

                @google_authentication_link = RubyApp::Elements::Mobile::Buttons::GoogleButton.new
                @google_authentication_link.clicked do |element, event|
                  RubyApp::Session.documents.push(RubyApp::Elements::Mobile::Documents::Authentication::OpenId::GoogleAuthenticationDocument.new)
                  event.refresh_browser
                end

                @my_open_id_authentication_link = RubyApp::Elements::Mobile::Buttons::MyOpenIDButton.new
                @my_open_id_authentication_link.clicked do |element, event|
                  RubyApp::Session.documents.push(RubyApp::Elements::Mobile::Documents::Authentication::OpenId::MyOpenIdAuthenticationDocument.new)
                  event.refresh_browser
                end

                @yahoo_authentication_link = RubyApp::Elements::Mobile::Buttons::YahooButton.new
                @yahoo_authentication_link.clicked do |element, event|
                  RubyApp::Session.documents.push(RubyApp::Elements::Mobile::Documents::Authentication::OpenId::YahooAuthenticationDocument.new)
                  event.refresh_browser
                end

              end

            end

          end

        end

      end

    end

  end

end
