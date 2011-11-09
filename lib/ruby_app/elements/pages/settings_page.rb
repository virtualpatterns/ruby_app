module RubyApp

  module Elements

    module Pages
      require 'ruby_app/elements/markdown'
      require 'ruby_app/elements/pages/blank_page'

      class SettingsPage < RubyApp::Elements::Pages::BlankPage

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super

          @markdown = RubyApp::Elements::Markdown.new
          @markdown.clicked do |element, event|
            case event.name
              when 'do_load_theme_mobile'
                require 'ruby_app/themes/mobile'
              when 'do_reload_translations'
                RubyApp::Language.reload!
              when 'do_quit'
                RubyApp::Session.quit
            end
            event.refresh
          end

        end

      end

    end

  end

end
