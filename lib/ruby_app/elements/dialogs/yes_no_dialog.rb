module RubyApp

  module Elements

    module Dialogs
      require 'ruby_app/elements/dialogs/base/base_yes_no_dialog'

      class YesNoDialog < RubyApp::Elements::Dialogs::Base::BaseYesNoDialog

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super
        end

      end

    end

  end

end
