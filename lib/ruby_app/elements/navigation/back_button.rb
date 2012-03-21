module RubyApp

  module Elements

    module Navigation
      require 'ruby_app'
      require 'ruby_app/elements/button'

      class BackButton < RubyApp::Elements::Button

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super

          self.clicked do |element, event|
            RubyApp::Session.pages.pop
            event.refresh
          end

        end

      end

    end

  end

end
