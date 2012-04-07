module RubyApp

  module Elements

    module Mobile
      require 'ruby_app/elements/mobile/link'

      class Button < RubyApp::Elements::Mobile::Link

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super
          self.attributes.merge!('data-role' => 'button')
        end

      end

    end

  end

end
