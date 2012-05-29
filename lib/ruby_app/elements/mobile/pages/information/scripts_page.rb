module RubyApp

  module Elements

    module Mobile

      module Pages

        module Information
          require 'ruby_app/elements/mobile/dialogs/acknowledgement_dialog'
          require 'ruby_app/elements/mobile/navigation/back_button'
          require 'ruby_app/elements/mobile/pages/information/scripts_list'
          require 'ruby_app/elements/mobile/page'

          class ScriptsPage < RubyApp::Elements::Mobile::Page

            template_path(:all, File.dirname(__FILE__))

            def initialize
              super

              @back_button = RubyApp::Elements::Mobile::Navigation::BackButton.new

              @scripts_list = RubyApp::Elements::Mobile::Pages::Information::ScriptsList.new
              @scripts_list.item_clicked do |element, event|
                if RubyApp::Session.configuration.scripts.enabled
                  event.go(event.item.script.url)
                else
                  RubyApp::Elements::Mobile::Dialog.show(event, RubyApp::Elements::Mobile::Dialogs::AcknowledgementDialog.new('Scripts', 'Scripts are currently disabled.'))
                end
              end

            end

          end

        end

      end

    end

  end

end
