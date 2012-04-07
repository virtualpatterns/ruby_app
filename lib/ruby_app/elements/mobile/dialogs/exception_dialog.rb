module RubyApp

  module Elements

    module Mobile

      module Dialogs
        require 'ruby_app/elements/mobile/dialogs/response_dialog'

        class ExceptionDialog < RubyApp::Elements::Mobile::Dialogs::ResponseDialog

          template_path(:all, File.dirname(__FILE__))

          def initialize(exception)
            super()

            @exception = exception

            @close_link = RubyApp::Elements::Mobile::Dialogs::ResponseDialog::CloseLink.new
            @close_link.clicked do |element, event|
              self.hide(event, element.options)
            end

          end

          def self.show_on_exception(event, options = {})
            begin
              yield
            rescue Exception => exception
              RubyApp::Log.exception(exception)
              self.show(event, RubyApp::Elements::Mobile::Dialogs::ExceptionDialog.new(exception), options)
            end
          end

        end

      end

    end

  end

end
