module RubyApp

  module Elements

    module Mobile

      module Default
        require 'ruby_app/elements/mobile/default/features/default_page'
        require 'ruby_app/elements/mobile/navigation/navigation_button'
        require 'ruby_app/elements/mobile/navigation/page_button'
        require 'ruby_app/elements/mobile/page'
        require 'ruby_app/elements/mobile/pages/information_page'

        class DefaultPage < RubyApp::Elements::Mobile::Page

          template_path(:all, File.dirname(__FILE__))

          def initialize
            super

            @features_link = RubyApp::Elements::Mobile::Navigation::PageButton.new
            @features_link.page = RubyApp::Elements::Mobile::Default::Features::DefaultPage

            @information_link = RubyApp::Elements::Mobile::Navigation::NavigationButton.new
            @information_link.clicked do |element, event|
              RubyApp::Elements::Mobile::Pages::InformationPage.new(event.now).show(event, element.options)
            end

          end

        end

      end

    end

  end

end
