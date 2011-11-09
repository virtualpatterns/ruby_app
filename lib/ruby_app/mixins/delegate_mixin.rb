module RubyApp

  module Mixins

    module DelegateMixin

      def method_missing(name, *arguments, &block)
        self.get.send(name, *arguments, &block)
      end

    end

  end

end
