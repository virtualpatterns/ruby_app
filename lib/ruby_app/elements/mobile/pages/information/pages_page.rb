module RubyApp

  module Elements

    module Mobile

      module Pages

        module Information
          require 'ruby_app/elements/mobile/navigation/back_button'
          require 'ruby_app/elements/mobile/pages/information/pages_list'
          require 'ruby_app/elements/mobile/page'
          require 'ruby_app/elements/mobile/pages/information/page_page'

          class PagesPage < RubyApp::Elements::Mobile::Page

            template_path(:all, File.dirname(__FILE__))

            def initialize(document)
              super()

              @document = document

              @back_button = RubyApp::Elements::Mobile::Navigation::BackButton.new

              @pages_list = RubyApp::Elements::Mobile::Pages::Information::PagesList.new(@document)
              @pages_list.item_clicked do |element, event|
                RubyApp::Elements::Mobile::Pages::Information::PagePage.new(event.item).show(event, element.options)
              end

            end

          end

        end

      end

    end

  end

end
