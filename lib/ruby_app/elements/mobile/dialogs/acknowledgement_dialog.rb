module RubyApp

  module Elements

    module Mobile

      module Dialogs
        require 'ruby_app/elements/mobile/dialogs/response_dialog'

        class AcknowledgementDialog < RubyApp::Elements::Mobile::Dialogs::ResponseDialog

          template_path(:all, File.dirname(__FILE__))

          def initialize(title, message)
            super()

            @response = false

            @title = title
            @message = message

            @ok_link = RubyApp::Elements::Mobile::Dialogs::ResponseDialog::CloseLink.new
            @ok_link.clicked do |element, event|
              @response = true
              self.hide(event, element.options)
            end

          end

        end

      end

    end

  end

end
