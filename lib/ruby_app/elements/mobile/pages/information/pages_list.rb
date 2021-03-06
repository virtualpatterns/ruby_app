module RubyApp

  module Elements

    module Mobile

      module Pages

        module Information
          require 'ruby_app/elements/mobile/pages/information/information_list'

          class PagesList < RubyApp::Elements::Mobile::Pages::Information::InformationList

            class PagesListItem < RubyApp::Elements::Mobile::Pages::Information::InformationList::InformationListItem

              template_path(:all, File.dirname(__FILE__))

              alias :page :item

              def initialize(page)
                super(page)
              end

            end

            template_path(:all, File.dirname(__FILE__))

            def initialize(document)
              super()
              self.items = document.pages.collect { |page| RubyApp::Elements::Mobile::Pages::Information::PagesList::PagesListItem.new(page) }
            end

          end

        end

      end

    end

  end

end
