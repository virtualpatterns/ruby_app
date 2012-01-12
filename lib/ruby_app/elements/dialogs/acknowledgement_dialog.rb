module RubyApp

  module Elements

    module Dialogs
      require 'ruby_app/elements/dialogs/ok_dialog'

      class AcknowledgementDialog < RubyApp::Elements::Dialogs::OkDialog

        template_path(:all, File.dirname(__FILE__))

        def initialize(title, message)
          super()

          @title = title
          @message = message

        end

      end

    end

  end

end
