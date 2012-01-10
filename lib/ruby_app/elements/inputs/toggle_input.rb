module RubyApp

  module Elements

    module Inputs
      require 'ruby_app/elements/input'

      class ToggleInput < RubyApp::Elements::Input

        template_path(:all, File.dirname(__FILE__))

        exclude_parent_template(:html, :js)

        def initialize
          super
        end

        protected

          def on_changed(event)
            @value = event.value =~ /(true|t|yes|y|on)/ ? true : false
            changed(event)
          end

      end

    end

  end

end
