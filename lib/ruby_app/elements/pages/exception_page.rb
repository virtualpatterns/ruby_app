module RubyApp

  module Elements

    module Pages
      require 'ruby_app/elements/page'

      class ExceptionPage < RubyApp::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize(exception)
          super()
          @exception = exception
        end

      end

    end

  end

end
