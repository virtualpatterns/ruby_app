module RubyApp

  module Elements

    module Dialogs
      require 'ruby_app/elements/dialogs/base/base_close_dialog'

      class CloseDialog < RubyApp::Elements::Dialogs::Base::BaseCloseDialog

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super
        end

      end

    end

  end

end
