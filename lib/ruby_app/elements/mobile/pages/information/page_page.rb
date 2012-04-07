module RubyApp

  module Elements

    module Mobile

      module Pages

        module Information
          require 'ruby_app/elements/mobile/navigation/back_button'
          require 'ruby_app/elements/mobile/page'

          class PagePage < RubyApp::Elements::Mobile::Page

            template_path(:all, File.dirname(__FILE__))

            def initialize(page)
              super()

              @page = page

              @back_button = RubyApp::Elements::Mobile::Navigation::BackButton.new

            end

          end

        end

      end

    end

  end

end
