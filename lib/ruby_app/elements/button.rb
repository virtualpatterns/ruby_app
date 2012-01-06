module RubyApp

  module Elements
    require 'ruby_app/elements/click'

    class Button < RubyApp::Elements::Click

      template_path(:all, File.dirname(__FILE__))

      def initialize
        super
      end

    end

  end

end
