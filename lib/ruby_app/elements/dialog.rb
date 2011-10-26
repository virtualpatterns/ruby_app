require 'rubygems'
require 'bundler/setup'

require 'ruby-event'

module RubyApp

  module Elements
    require 'ruby_app/elements/base/base_dialog'

    class Dialog < RubyApp::Elements::Base::BaseDialog

      template_path(:all, File.dirname(__FILE__))

      def initialize
        super
      end

    end

  end

end
