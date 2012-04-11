require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module _APPLICATION_UPCODE_

  module Elements

    module Documents

      class DefaultDocument < RubyApp::Elements::Mobile::Platforms::Ios::Document

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super

          require '_APPLICATION_DOWNCODE_/elements/pages/default_page'
          self.pages.push(_APPLICATION_UPCODE_::Elements::Pages::DefaultPage.new)

        end

      end

    end

  end

end
