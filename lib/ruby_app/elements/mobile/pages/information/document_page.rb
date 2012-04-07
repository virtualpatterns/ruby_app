module RubyApp

  module Elements

    module Mobile

      module Pages

        module Information
          require 'ruby_app/elements/mobile/navigation/back_button'
          require 'ruby_app/elements/mobile/navigation/navigation_link'
          require 'ruby_app/elements/mobile/page'
          require 'ruby_app/elements/mobile/pages/information/pages_page'

          class DocumentPage < RubyApp::Elements::Mobile::Page

            template_path(:all, File.dirname(__FILE__))

            def initialize(document)
              super()

              @document = document

              @back_button = RubyApp::Elements::Mobile::Navigation::BackButton.new

              @pages_link = RubyApp::Elements::Mobile::Navigation::NavigationLink.new
              @pages_link.clicked do |element, event|
                RubyApp::Elements::Mobile::Pages::Information::PagesPage.new(@document).show(event, element.options)
              end

            end

          end

        end

      end

    end

  end

end
