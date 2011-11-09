module RubyApp

  module Elements

    module Pages

      module TestPages
        require 'ruby_app/elements/markdown'
        require 'ruby_app/elements/pages/blank_page'
        require 'ruby_app/elements/pages/test_pages/linked_test_page'
        require 'ruby_app/session'

        class MarkdownTestPage < RubyApp::Elements::Pages::BlankPage

          template_path(:all, File.dirname(__FILE__))

          def initialize
            super

            @markdown = RubyApp::Elements::Markdown.new
            @markdown.clicked do |element, event|
              if event.name == "go"
                RubyApp::Session.pages.push(RubyApp::Elements::Pages::TestPages::LinkedTestPage.new)
                event.refresh
              end
            end

          end

        end

      end

    end

  end

end
