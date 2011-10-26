module RubyApp

  module Elements

    module Dialogs

      module Base
        require 'ruby_app/elements/dialog'

        class BaseBusyDialog < RubyApp::Elements::Dialog

          template_path(:all, File.dirname(__FILE__))

          def initialize(message)
            super()
            @message = message
          end

        end

      end

    end

  end

end
