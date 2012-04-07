module RubyApp

  module Elements

    module Mobile

      module Pages

        module Information
          require 'ruby_app/elements/mobile/navigation/back_button'
          require 'ruby_app/elements/mobile/navigation/navigation_link'
          require 'ruby_app/elements/mobile/page'
          require 'ruby_app/elements/mobile/pages/information/documents_page'

          class SessionPage < RubyApp::Elements::Mobile::Page

            template_path(:all, File.dirname(__FILE__))

            def initialize(session)
              super()

              @session = session

              @back_button = RubyApp::Elements::Mobile::Navigation::BackButton.new

              @documents_link = RubyApp::Elements::Mobile::Navigation::NavigationLink.new
              @documents_link.clicked do |element, event|
                RubyApp::Elements::Mobile::Pages::Information::DocumentsPage.new(@session).show(event, element.options)
              end

            end

          end

        end

      end

    end

  end

end
