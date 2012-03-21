module RubyApp

  module Exceptions

    module Base
      require 'ruby_app/mixins'

      class BaseException < Exception
        extend RubyApp::Mixins::TranslateMixin

        def initialize(message)
          super(message)
        end

      end

    end

  end

end
