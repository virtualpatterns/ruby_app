module RubyApp

  module Elements
    require 'ruby_app/elements/click'

    class Button < RubyApp::Elements::Click

      template_path(:all, File.dirname(__FILE__))

      def initialize
        super
        attributes.merge!(:type => :button)
      end

    end

  end

end
