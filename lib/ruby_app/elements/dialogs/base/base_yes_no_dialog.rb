module RubyApp

  module Elements

    module Dialogs

      module Base
        require 'ruby_app/elements/dialogs/blank_dialog'
        require 'ruby_app/elements/link'

        class BaseYesNoDialog < RubyApp::Elements::Dialogs::BlankDialog

          template_path(:all, File.dirname(__FILE__))

          def initialize
            super

            @yes = RubyApp::Elements::Link.new
            @yes.clicked do |element, event|
              @response = true
              event.hide(self)
            end

            @no = RubyApp::Elements::Link.new
            @no.clicked do |element, event|
              @response = false
              event.hide(self)
            end

          end

        end

      end

    end

  end

end
