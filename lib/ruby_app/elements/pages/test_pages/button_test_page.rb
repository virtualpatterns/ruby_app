module RubyApp

  module Elements

    module Pages

      module TestPages
        require 'ruby_app'
        require 'ruby_app/elements'

        class ButtonTestPage < RubyApp::Elements::Pages::BlankPage

          template_path(:all, File.dirname(__FILE__))

          def initialize
            super

            @markdown = RubyApp::Elements::Markdown.new

            @button = RubyApp::Elements::Button.new
            @button.clicked do |element, event|
              require 'ruby_app/elements/pages/test_pages/linked_test_page'
              RubyApp::Session.pages.push(RubyApp::Elements::Pages::TestPages::LinkedTestPage.new)
              event.refresh
            end

          end

        end

      end

    end

  end

end
