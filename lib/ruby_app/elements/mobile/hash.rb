module RubyApp

  module Elements

    module Mobile
      require 'ruby_app/element'

      class Hash < RubyApp::Element

        template_path(:all, File.dirname(__FILE__))

        attr_reader :data

        def initialize(data)
          super()
          @data = data
        end

      end

    end

  end

end
