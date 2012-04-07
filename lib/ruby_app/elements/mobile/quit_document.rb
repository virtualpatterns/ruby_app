module RubyApp

  module Elements

    module Mobile
      require 'ruby_app/elements/mobile/document'

      class QuitDocument < RubyApp::Elements::Mobile::Document

        template_path(:all, File.dirname(__FILE__))

        exclude_parent_template(:all)

        def initialize
          super
        end

      end

    end

  end

end
