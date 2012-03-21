module RubyApp

  module Elements

    module Pages

      module TestPages
        require 'ruby_app'
        require 'ruby_app/elements'

        class DefaultTestPage < RubyApp::Elements::Pages::BlankPage

          template_path(:all, File.dirname(__FILE__))

          def initialize
            super

            @markdown = RubyApp::Elements::Markdown.new
            @markdown.clicked do |element, event|
              require 'ruby_app/elements/pages/test_pages/button_test_page'
              require 'ruby_app/elements/pages/test_pages/dialog_test_page'
              require 'ruby_app/elements/pages/test_pages/input_test_page'
              require 'ruby_app/elements/pages/test_pages/link_test_page'
              require 'ruby_app/elements/pages/test_pages/list_test_page'
              require 'ruby_app/elements/pages/test_pages/markdown_test_page'
              require 'ruby_app/elements/pages/test_pages/test_page'
              RubyApp::Session.pages.push(Kernel.eval(event.name).new)
              event.refresh
            end

          end

        end

      end

    end

  end

end
