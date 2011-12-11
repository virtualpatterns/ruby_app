module RubyApp

  module Exceptions

    module Base
      require 'ruby_app/mixins/translate_mixin'

      class BaseException < Exception
        extend RubyApp::Mixins::TranslateMixin

        def initialize(message)
          super(message)
        end

      end

    end

  end

end
