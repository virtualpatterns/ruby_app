module RubyApp

  module Elements

    module Dialogs
      require 'ruby_app'
      require 'ruby_app/elements/dialogs/close_dialog'

      class ExceptionDialog < RubyApp::Elements::Dialogs::CloseDialog

        template_path(:all, File.dirname(__FILE__))

        def initialize(exception)
          super()
          @exception = exception
        end

        def self.show_dialog(event)
          begin
            yield
          rescue Exception => exception
            RubyApp::Log.exception(exception)
            RubyApp::Session.show_dialog(event, RubyApp::Elements::Dialogs::ExceptionDialog.new(exception))
          end
        end

      end

    end

  end

end
