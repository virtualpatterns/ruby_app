require 'rubygems'
require 'bundler/setup'

module RubyApp

  module Elements

    module Mobile

      module Documents

        module Authentication

          module Null
            require 'ruby_app'
            require 'ruby_app/elements/mobile/documents/authentication/authentication_document'

            class AuthenticationDocument < RubyApp::Elements::Mobile::Documents::Authentication::AuthenticationDocument

              template_path(:all, File.dirname(__FILE__))

              def initialize
                super
              end

            end

          end

        end

      end

    end

  end

end
