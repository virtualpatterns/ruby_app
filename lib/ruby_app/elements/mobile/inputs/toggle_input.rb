module RubyApp

  module Elements

    module Mobile

      module Inputs
        require 'ruby_app/elements/mobile/input'

        class ToggleInput < RubyApp::Elements::Mobile::Input

          class ChangedEvent < RubyApp::Elements::Mobile::Input::ChangedEvent

            def initialize(data)
              super(data)
              @value = @value.to_b
            end

          end

          template_path(:all, File.dirname(__FILE__))

          exclude_parent_template(:all)

          def initialize
            super
            self.attributes.delete('type')
            self.attributes.merge!('data-role' => 'slider')

            @value = false

          end

        end

      end

    end

  end

end
