require 'rubygems'
require 'bundler/setup'

module RubyApp

  module Elements
    require 'ruby_app/elements/base/base_page'

    class Page < RubyApp::Elements::Base::BasePage

      template_path(:all, File.dirname(__FILE__))

      def initialize
        super
      end

    end

  end

end
