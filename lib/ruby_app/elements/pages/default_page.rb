module RubyApp

  module Elements

    module Pages
      require 'ruby_app/elements/markdown'
      require 'ruby_app/elements/pages/blank_page'
      require 'ruby_app/elements/pages/test_pages/default_test_page'

      class DefaultPage < RubyApp::Elements::Pages::BlankPage

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super

          @markdown = RubyApp::Elements::Markdown.new
          @markdown.navigated do |element, event|
            case event.name
              when 'go_test'
                RubyApp::Session.pages.push(RubyApp::Elements::Pages::TestPages::DefaultTestPage.new)
                event.refresh
            end
          end

        end

      end

    end

  end

end
