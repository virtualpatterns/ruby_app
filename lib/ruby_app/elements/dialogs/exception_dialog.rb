module RubyApp

  module Elements

    module Dialogs
      require 'ruby_app/elements/dialogs/close_dialog'
      require 'ruby_app/session'

      class ExceptionDialog < RubyApp::Elements::Dialogs::CloseDialog

        template_path(:all, File.dirname(__FILE__))

        def initialize(exception)
          super()
          @exception = exception
        end

        def self.show(event)
          begin
            yield
          rescue Exception => exception
            RubyApp::Session.show(event, RubyApp::Elements::Dialogs::ExceptionDialog.new(exception))
          end
        end

      end

    end

  end

end
