module RubyApp

  module Elements

    module Base
      require 'ruby_app'
      require 'ruby_app/element'
      require 'ruby_app/mixins'

      class BaseMail < RubyApp::Element
        include RubyApp::Mixins::HashMixin

        template_path(:all, File.dirname(__FILE__))

        attr_reader :data

        def initialize
          super
          @data = {}
        end

        def [](key)
          @data[key]
        end

        def []=(key, value)
          @data[key] = value
        end

      end

    end

  end

end
