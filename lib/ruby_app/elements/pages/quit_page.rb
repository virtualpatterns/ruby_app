module RubyApp

  module Elements

    module Pages
      require 'ruby_app/elements/page'

      class QuitPage < RubyApp::Elements::Page

        template_path(:all, File.dirname(__FILE__))
        exclude_parent_template(:all)

        def initialize
          super
        end

      end

    end

  end

end
