module RubyApp

  module Elements

    module Mobile

      module Navigation
        require 'ruby_app/elements/mobile/navigation/navigation_button'

        class PageButton < RubyApp::Elements::Mobile::Navigation::NavigationButton

          template_path(:all, File.dirname(__FILE__))

          attr_accessor :page

          def initialize
            super

            @page = nil

            self.clicked do |element, event|
              page = @page.new
              page.show(event, self.options)
            end

          end

        end

      end

    end

  end

end
