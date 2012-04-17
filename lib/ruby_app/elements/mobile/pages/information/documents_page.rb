module RubyApp

  module Elements

    module Mobile

      module Pages

        module Information
          require 'ruby_app/elements/mobile/navigation/back_button'
          require 'ruby_app/elements/mobile/pages/information/documents_list'
          require 'ruby_app/elements/mobile/page'
          require 'ruby_app/elements/mobile/pages/information/document_page'

          class DocumentsPage < RubyApp::Elements::Mobile::Page

            template_path(:all, File.dirname(__FILE__))

            def initialize(session)
              super()

              @session = session

              @back_button = RubyApp::Elements::Mobile::Navigation::BackButton.new

              @documents_list = RubyApp::Elements::Mobile::Pages::Information::DocumentsList.new(@session)
              @documents_list.item_clicked do |element, event|
                RubyApp::Elements::Mobile::Pages::Information::DocumentPage.new(event.item).show(event, element.options)
              end

            end

          end

        end

      end

    end

  end

end
