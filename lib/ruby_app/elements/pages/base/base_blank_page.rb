module RubyApp

  module Elements

    module Pages

      module Base
        require 'ruby_app/elements/navigation/breadcrumbs'
        require 'ruby_app/elements/navigation/page_link'
        require 'ruby_app/elements/page'

        class BaseBlankPage < RubyApp::Elements::Page

          template_path(:all, File.dirname(__FILE__))

          def initialize
            super

            @breadcrumbs = RubyApp::Elements::Navigation::Breadcrumbs.new

            require 'ruby_app/elements/pages/settings_page'
            @settings = RubyApp::Elements::Navigation::PageLink.new
            @settings.page = RubyApp::Elements::Pages::SettingsPage

          end

        end

      end

    end

  end

end
