module RubyApp

  module Elements

    module Dialogs
      require 'ruby_app/elements'

      class BlankDialog < RubyApp::Elements::Dialog

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super
        end

      end

    end

  end

end
