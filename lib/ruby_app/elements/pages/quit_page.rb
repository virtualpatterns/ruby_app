module RubyApp

  module Elements

    module Pages
      require 'ruby_app/elements/page'
      require 'ruby_app/session'

      class QuitPage < RubyApp::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super
          RubyApp::Session.quit
        end

      end

    end

  end

end
