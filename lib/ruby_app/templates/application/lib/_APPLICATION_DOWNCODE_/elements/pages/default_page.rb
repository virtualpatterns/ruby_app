require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module _APPLICATION_UPCODE_

  module Elements

    module Pages

      class DefaultPage < RubyApp::Elements::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super
        end

      end

    end

  end

end
