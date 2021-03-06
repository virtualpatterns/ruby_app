module RubyApp

  module Elements

    module Mobile

      module Pages
        require 'ruby_app/elements/mobile/navigation/back_button'
        require 'ruby_app/elements/mobile/navigation/navigation_link'
        require 'ruby_app/elements/mobile/page'
        require 'ruby_app/elements/mobile/pages/information/configuration_page'
        require 'ruby_app/elements/mobile/pages/information/cookies_page'
        require 'ruby_app/elements/mobile/pages/information/environment_page'
        require 'ruby_app/elements/mobile/pages/information/sessions_page'

        class InformationPage < RubyApp::Elements::Mobile::Page

          template_path(:all, File.dirname(__FILE__))

          def initialize(now)
            super()

            @now = now

            @back_button = RubyApp::Elements::Mobile::Navigation::BackButton.new

            @environment_link = RubyApp::Elements::Mobile::Navigation::NavigationLink.new
            @environment_link.clicked do |element, event|
              RubyApp::Elements::Mobile::Pages::Information::EnvironmentPage.new.show(event, element.options)
            end

            @cookies_link = RubyApp::Elements::Mobile::Navigation::NavigationLink.new
            @cookies_link.clicked do |element, event|
              RubyApp::Elements::Mobile::Pages::Information::CookiesPage.new.show(event, element.options)
            end

            @configuration_link = RubyApp::Elements::Mobile::Navigation::NavigationLink.new
            @configuration_link.clicked do |element, event|
              RubyApp::Elements::Mobile::Pages::Information::ConfigurationPage.new.show(event, element.options)
            end

            @sessions_link = RubyApp::Elements::Mobile::Navigation::NavigationLink.new
            @sessions_link.clicked do |element, event|
              RubyApp::Elements::Mobile::Pages::Information::SessionsPage.new.show(event, element.options)
            end

          end

        end

      end

    end

  end

end
