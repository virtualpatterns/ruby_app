module RubyApp

  module Elements

    module Mobile
      require 'ruby_app/elements/mobile/click'

      class Link < RubyApp::Elements::Mobile::Click

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super
          self.attributes.merge!('href' => '#')
        end

      end

    end

  end

end
