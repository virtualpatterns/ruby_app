module RubyApp

  module Elements

    module Dialogs
      require 'ruby_app/elements/dialogs/base/base_ok_dialog'

      class OkDialog < RubyApp::Elements::Dialogs::Base::BaseOkDialog

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super
        end

      end

    end

  end

end
