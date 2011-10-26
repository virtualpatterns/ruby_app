module RubyApp

  module Elements

    module Dialogs
      require 'ruby_app/elements/dialogs/base/base_busy_dialog'

      class BusyDialog < RubyApp::Elements::Dialogs::Base::BaseBusyDialog

        template_path(:all, File.dirname(__FILE__))

        def initialize(message)
          super(message)
        end

      end

    end

  end

end
