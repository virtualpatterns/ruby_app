module RubyApp

  module Elements

    module Mobile

      module Default

        module Features

          module Authentications
            require 'ruby_app'
            require 'ruby_app/elements/mobile/button'
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

                @google_authentication_link = RubyApp::Elements::Mobile::Button.new
                @google_authentication_link.clicked do |element, event|
                  RubyApp::Session.documents.push(RubyApp::Elements::Mobile::Documents::Authentication::OpenId::GoogleAuthenticationDocument.new)
                  event.refresh
                end

                @yahoo_authentication_link = RubyApp::Elements::Mobile::Button.new
                @yahoo_authentication_link.clicked do |element, event|
                  RubyApp::Session.documents.push(RubyApp::Elements::Mobile::Documents::Authentication::OpenId::YahooAuthenticationDocument.new)
                  event.refresh
                end

              end

            end

          end

        end

      end

    end

  end

end
