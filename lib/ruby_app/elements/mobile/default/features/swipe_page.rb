module RubyApp

  module Elements

    module Mobile

      module Default

        module Features
          require 'ruby_app/elements/mobile/button'
          require 'ruby_app/elements/mobile/default/features/navigated_page'
          require 'ruby_app/elements/mobile/navigation/back_button'
          require 'ruby_app/elements/mobile/page'

          class SwipePage < RubyApp::Elements::Mobile::Page

            template_path(:all, File.dirname(__FILE__))

            def initialize
              super

              @back_button = RubyApp::Elements::Mobile::Navigation::BackButton.new

              self.swiped do |element, event|
                RubyApp::Elements::Mobile::Default::Features::NavigatedPage.new.show(event, :transition => 'slide', :reverse => event.is_a?(RubyApp::Elements::Mobile::Page::SwipedRightEvent) ? true : false)
              end

            end

          end

        end

      end

    end

  end

end
