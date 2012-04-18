module RubyApp

  module Elements

    module Mobile

      module Pages

        module Information
          require 'ruby_app/elements/mobile/pages/information/information_list'

          class DocumentsList < RubyApp::Elements::Mobile::Pages::Information::InformationList

            class DocumentsListItem < RubyApp::Elements::Mobile::Pages::Information::InformationList::InformationListItem

              template_path(:all, File.dirname(__FILE__))

              alias :document :item

              def initialize(document)
                super(document)
              end

            end

            template_path(:all, File.dirname(__FILE__))

            def initialize(session)
              super()
              self.items = session.documents.collect { |document| RubyApp::Elements::Mobile::Pages::Information::DocumentsList::DocumentsListItem.new(document) }
            end

          end

        end

      end

    end

  end

end
