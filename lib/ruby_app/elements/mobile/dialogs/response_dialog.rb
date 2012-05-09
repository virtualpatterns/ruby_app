module RubyApp

  module Elements

    module Mobile

      module Dialogs
        require 'ruby_app/elements/mobile/dialog'
        require 'ruby_app/elements/mobile/navigation/hide_button'

        class ResponseDialog < RubyApp::Elements::Mobile::Dialog

          class CloseLink < RubyApp::Elements::Mobile::Navigation::HideButton

            template_path(:all, File.dirname(__FILE__))

            def initialize
              super
              self.attributes.merge!('data-inline' => 'true')
              self.options.merge!(:transition => 'pop')
            end

          end

          template_path(:all, File.dirname(__FILE__))

          attr_reader :response

          def initialize
            super
            @response = nil
          end

        end

      end

    end

  end

end
