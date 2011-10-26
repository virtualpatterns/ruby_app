module RubyApp

  module Elements

    module Dialogs
      require 'ruby_app/elements/dialogs/close_dialog'

      class MessageDialog < RubyApp::Elements::Dialogs::CloseDialog

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
