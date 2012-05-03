module RubyApp

  module Elements

    module Mobile

      module Default

        module Features

          module Navigation
            require 'ruby_app'
            require 'ruby_app/elements/mobile/default/features/navigated_page'
            require 'ruby_app/elements/mobile/navigation/back_button'
            require 'ruby_app/elements/mobile/navigation/navigation_list'
            require 'ruby_app/elements/mobile/page'

            class NavigationListPage < RubyApp::Elements::Mobile::Page

              template_path(:all, File.dirname(__FILE__))

              def initialize
                super

                @back_button = RubyApp::Elements::Mobile::Navigation::BackButton.new

                @navigation_list = RubyApp::Elements::Mobile::Navigation::NavigationList.new
                @navigation_list.items = [RubyApp::Elements::Mobile::Default::Features::NavigatedPage].collect { |page| RubyApp::Elements::Mobile::Navigation::NavigationList::NavigationListPageItem.new(page) }

              end

            end

          end

        end

      end

    end

  end

end
