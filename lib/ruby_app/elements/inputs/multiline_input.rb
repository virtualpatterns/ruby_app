module RubyApp

  module Elements

    module Inputs
      require 'ruby_app/elements/input'

      class MultilineInput < RubyApp::Elements::Input

        template_path(:all, File.dirname(__FILE__))

        exclude_parent_template(:html, :js)

        def initialize
          super
        end

      end

    end

  end

end
