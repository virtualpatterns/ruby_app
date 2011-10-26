module RubyApp

  module Elements

    module Dialogs

      module Base
        require 'ruby_app/elements/dialogs/blank_dialog'
        require 'ruby_app/elements/link'

        class BaseCloseDialog < RubyApp::Elements::Dialogs::BlankDialog

          template_path(:all, File.dirname(__FILE__))

          def initialize
            super

            @close = RubyApp::Elements::Link.new
            @close.clicked do |element, event|
              event.hide(self)
            end

          end

        end

      end

    end

  end

end
