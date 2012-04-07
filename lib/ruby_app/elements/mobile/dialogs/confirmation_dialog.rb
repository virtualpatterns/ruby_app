module RubyApp

  module Elements

    module Mobile

      module Dialogs
        require 'ruby_app/elements/mobile/dialogs/response_dialog'

        class ConfirmationDialog < RubyApp::Elements::Mobile::Dialogs::ResponseDialog

          template_path(:all, File.dirname(__FILE__))

          def initialize(title, message)
            super()

            @title = title
            @message = message

            @yes_link = RubyApp::Elements::Mobile::Dialogs::ResponseDialog::CloseLink.new
            @yes_link.clicked do |element, event|
              @response = true
              self.hide(event, element.options)
            end

            @no_link = RubyApp::Elements::Mobile::Dialogs::ResponseDialog::CloseLink.new
            @no_link.clicked do |element, event|
              @response = false
              self.hide(event, element.options)
            end

          end

        end

      end

    end

  end

end
