module RubyApp

  module Elements

    module Mobile

      module Pages

        module Information
          require 'ruby_app/elements/mobile/hash'
          require 'ruby_app/elements/mobile/navigation/back_button'
          require 'ruby_app/elements/mobile/page'

          class CookiesPage < RubyApp::Elements::Mobile::Page

            template_path(:all, File.dirname(__FILE__))

            def initialize
              super

              @back_button = RubyApp::Elements::Mobile::Navigation::BackButton.new

              @cookies_hash = RubyApp::Elements::Mobile::Hash.new(RubyApp::Request.cookies)

            end

          end

        end

      end

    end

  end

end
