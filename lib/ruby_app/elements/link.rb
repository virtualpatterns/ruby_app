module RubyApp

  module Elements
    require 'ruby_app/elements/click'

    class Link < RubyApp::Elements::Click

      template_path(:all, File.dirname(__FILE__))

      def initialize
        super
        attributes.merge!(:href => '')
      end

    end

  end

end
