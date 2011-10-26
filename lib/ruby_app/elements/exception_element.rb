module RubyApp

  module Elements
    require 'ruby_app/element'

    class ExceptionElement < RubyApp::Element

      template_path(:all, File.dirname(__FILE__))

      def initialize(exception)
        super()
        @exception = exception
      end

    end

  end

end
