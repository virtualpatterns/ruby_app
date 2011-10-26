module RubyApp

  module Elements

    module Pages
      require 'ruby_app/elements/pages/base/base_blank_page'

      class BlankPage < RubyApp::Elements::Pages::Base::BaseBlankPage

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super
        end

      end

    end

  end

end
