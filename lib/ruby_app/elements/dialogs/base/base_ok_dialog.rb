module RubyApp

  module Elements

    module Dialogs

      module Base
        require 'ruby_app/elements/dialogs/blank_dialog'

        class BaseOkDialog < RubyApp::Elements::Dialogs::BlankDialog

          template_path(:all, File.dirname(__FILE__))

          def initialize
            super

            @ok = RubyApp::Elements::Link.new
            @ok.clicked do |element, event|
              @response = true
              event.hide_dialog(self)
            end

          end

        end

      end

    end

  end

end
