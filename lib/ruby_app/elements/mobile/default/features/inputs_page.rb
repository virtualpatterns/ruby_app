module RubyApp

  module Elements

    module Mobile

      module Default

        module Features
          require 'ruby_app/elements/mobile/dialogs/acknowledgement_dialog'
          require 'ruby_app/elements/mobile/input'
          require 'ruby_app/elements/mobile/inputs/duration_input'
          require 'ruby_app/elements/mobile/inputs/email_input'
          require 'ruby_app/elements/mobile/inputs/multiline_input'
          require 'ruby_app/elements/mobile/inputs/toggle_input'
          require 'ruby_app/elements/mobile/navigation/back_button'
          require 'ruby_app/elements/mobile/page'

          class InputsPage < RubyApp::Elements::Mobile::Page

            template_path(:all, File.dirname(__FILE__))

            def initialize
              super

              @back_button = RubyApp::Elements::Mobile::Navigation::BackButton.new

              @simple_input = RubyApp::Elements::Mobile::Input.new
              @simple_input.changed do |element, event|
                RubyApp::Elements::Mobile::Dialog.show(event, RubyApp::Elements::Mobile::Dialogs::AcknowledgementDialog.new('Simple Input', "You input #{@simple_input.value}."), :transition => 'pop')
              end

              @date_input = RubyApp::Elements::Mobile::Inputs::DateInput.new
              @date_input.changed do |element, event|
                RubyApp::Elements::Mobile::Dialog.show(event, RubyApp::Elements::Mobile::Dialogs::AcknowledgementDialog.new('Date Input', "You input #{@date_input.value}."), :transition => 'pop')
              end

              @duration_input = RubyApp::Elements::Mobile::Inputs::DurationInput.new
              @duration_input.changed do |element, event|
                RubyApp::Elements::Mobile::Dialog.show(event, RubyApp::Elements::Mobile::Dialogs::AcknowledgementDialog.new('Duration Input', "You input #{@duration_input.duration}."), :transition => 'pop')
              end

              @email_input = RubyApp::Elements::Mobile::Inputs::EmailInput.new
              @email_input.changed do |element, event|
                RubyApp::Elements::Mobile::Dialog.show(event, RubyApp::Elements::Mobile::Dialogs::AcknowledgementDialog.new('Email Input', "You input #{@email_input.value}."), :transition => 'pop')
              end

              @multiline_input = RubyApp::Elements::Mobile::Inputs::MultilineInput.new
              @multiline_input.changed do |element, event|
                RubyApp::Elements::Mobile::Dialog.show(event, RubyApp::Elements::Mobile::Dialogs::AcknowledgementDialog.new('Multiline Input', "You input #{@multiline_input.value}."), :transition => 'pop')
              end

              @toggle_input = RubyApp::Elements::Mobile::Inputs::ToggleInput.new
              @toggle_input.changed do |element, event|
                RubyApp::Elements::Mobile::Dialog.show(event, RubyApp::Elements::Mobile::Dialogs::AcknowledgementDialog.new('Toggle Input', "You input #{@toggle_input.value}."), :transition => 'pop')
              end

            end

          end

        end

      end

    end

  end

end
