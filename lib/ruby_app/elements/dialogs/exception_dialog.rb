module RubyApp

  module Elements

    module Dialogs
      require 'ruby_app/elements/dialogs/close_dialog'

      class ExceptionDialog < RubyApp::Elements::Dialogs::CloseDialog

        template_path(:all, File.dirname(__FILE__))

        def initialize(exception)
          super()
          @exception = exception
        end

      end

    end

  end

end
