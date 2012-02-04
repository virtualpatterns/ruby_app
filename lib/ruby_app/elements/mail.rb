module RubyApp

  module Elements
    require 'ruby_app/elements/base/base_mail'

    class Mail < RubyApp::Elements::Base::BaseMail

      template_path(:all, File.dirname(__FILE__))

      def initialize
        super
      end

    end

  end

end
