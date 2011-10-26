module RubyApp

  module Elements

    module Dialogs
      require 'ruby_app/elements/dialogs/yes_no_dialog'

      class ConfirmationDialog < RubyApp::Elements::Dialogs::YesNoDialog

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
