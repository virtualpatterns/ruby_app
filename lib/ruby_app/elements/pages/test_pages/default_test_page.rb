module RubyApp

  module Elements

    module Pages

      module TestPages
        require 'ruby_app/elements/dialogs/busy_dialog'
        require 'ruby_app/elements/dialogs/exception_dialog'
        require 'ruby_app/elements/markdown'
        require 'ruby_app/elements/pages/authentication/open_id/google_authentication_page'
        require 'ruby_app/elements/pages/authentication/open_id/my_open_id_authentication_page'
        require 'ruby_app/elements/pages/authentication/open_id/yahoo_authentication_page'
        require 'ruby_app/elements/pages/blank_page'
        require 'ruby_app/elements/pages/test_pages/button_test_page'
        require 'ruby_app/elements/pages/test_pages/dialog_test_page'
        require 'ruby_app/elements/pages/test_pages/exception_test_page'
        require 'ruby_app/elements/pages/test_pages/input_test_page'
        require 'ruby_app/elements/pages/test_pages/link_test_page'
        require 'ruby_app/elements/pages/test_pages/list_test_page'
        require 'ruby_app/elements/pages/test_pages/markdown_test_page'
        require 'ruby_app/elements/pages/test_pages/test_page'
        require 'ruby_app/session'

        class DefaultTestPage < RubyApp::Elements::Pages::BlankPage

          template_path(:all, File.dirname(__FILE__))

          def initialize
            super

            @markdown = RubyApp::Elements::Markdown.new
            @markdown.clicked do |element, event|
              RubyApp::Session.pages.push(eval(event.name).new)
              event.refresh
            end

          end

        end

      end

    end

  end

end
