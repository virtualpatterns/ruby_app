module RubyApp

  module Elements

    module Mobile

      module Default

        module Features
          require 'ruby_app/elements/mobile/default/features/authentications/default_page'
          require 'ruby_app/elements/mobile/default/features/buttons_page'
          require 'ruby_app/elements/mobile/default/features/calendars/default_page'
          require 'ruby_app/elements/mobile/default/features/dialogs_page'
          require 'ruby_app/elements/mobile/default/features/document_document'
          require 'ruby_app/elements/mobile/default/features/inputs_page'
          require 'ruby_app/elements/mobile/default/features/lists_page'
          require 'ruby_app/elements/mobile/default/features/message_page'
          require 'ruby_app/elements/mobile/default/features/navigation/default_page'
          require 'ruby_app/elements/mobile/default/features/swipe_page'
          require 'ruby_app/elements/mobile/default/features/trigger_page'
          require 'ruby_app/elements/mobile/navigation/back_button'
          require 'ruby_app/elements/mobile/navigation/navigation_button'
          require 'ruby_app/elements/mobile/navigation/page_button'
          require 'ruby_app/elements/mobile/page'

          class DefaultPage < RubyApp::Elements::Mobile::Page

            template_path(:all, File.dirname(__FILE__))

            def initialize
              super

              @back_button = RubyApp::Elements::Mobile::Navigation::BackButton.new

              @authentications_link = RubyApp::Elements::Mobile::Navigation::PageButton.new
              @authentications_link.page = RubyApp::Elements::Mobile::Default::Features::Authentications::DefaultPage

              @buttons_link = RubyApp::Elements::Mobile::Navigation::PageButton.new
              @buttons_link.page = RubyApp::Elements::Mobile::Default::Features::ButtonsPage

              @calendars_link = RubyApp::Elements::Mobile::Navigation::PageButton.new
              @calendars_link.page = RubyApp::Elements::Mobile::Default::Features::Calendars::DefaultPage

              @dialogs_link = RubyApp::Elements::Mobile::Navigation::PageButton.new
              @dialogs_link.page = RubyApp::Elements::Mobile::Default::Features::DialogsPage

              @document_link = RubyApp::Elements::Mobile::Navigation::NavigationButton.new
              @document_link.clicked do |element, event|
                RubyApp::Session.documents.push(RubyApp::Elements::Mobile::Default::Features::DocumentDocument.new)
                event.refresh_browser
              end

              @inputs_link = RubyApp::Elements::Mobile::Navigation::PageButton.new
              @inputs_link.page = RubyApp::Elements::Mobile::Default::Features::InputsPage

              @lists_link = RubyApp::Elements::Mobile::Navigation::PageButton.new
              @lists_link.page = RubyApp::Elements::Mobile::Default::Features::ListsPage

              @message_link = RubyApp::Elements::Mobile::Navigation::PageButton.new
              @message_link.page = RubyApp::Elements::Mobile::Default::Features::MessagePage

              @navigation_link = RubyApp::Elements::Mobile::Navigation::PageButton.new
              @navigation_link.page = RubyApp::Elements::Mobile::Default::Features::Navigation::DefaultPage

              @swipe_link = RubyApp::Elements::Mobile::Navigation::PageButton.new
              @swipe_link.page = RubyApp::Elements::Mobile::Default::Features::SwipePage

              @trigger_link = RubyApp::Elements::Mobile::Navigation::PageButton.new
              @trigger_link.page = RubyApp::Elements::Mobile::Default::Features::TriggerPage

            end

          end

        end

      end

    end

  end

end
