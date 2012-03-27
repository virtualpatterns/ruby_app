module RubyApp

  module Elements

    module Mobile
    require 'ruby_app/element'

      class Document < RubyApp::Element

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super
        end

      end

    end

  end

end
