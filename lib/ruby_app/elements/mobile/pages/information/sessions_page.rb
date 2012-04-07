module RubyApp

  module Elements

    module Mobile

      module Pages

        module Information
          require 'ruby_app/elements/mobile/navigation/back_button'
          require 'ruby_app/elements/mobile/pages/information/sessions_list'
          require 'ruby_app/elements/mobile/page'
          require 'ruby_app/elements/mobile/pages/information/session_page'

          class SessionsPage < RubyApp::Elements::Mobile::Page

            template_path(:all, File.dirname(__FILE__))

            def initialize
              super

              @back_button = RubyApp::Elements::Mobile::Navigation::BackButton.new

              @sessions_list = RubyApp::Elements::Mobile::Pages::Information::SessionsList.new
              @sessions_list.clicked do |element, event|
                RubyApp::Elements::Mobile::Pages::Information::SessionPage.new(event.item).show(event, element.options)
              end

            end

          end

        end

      end

    end

  end

end
