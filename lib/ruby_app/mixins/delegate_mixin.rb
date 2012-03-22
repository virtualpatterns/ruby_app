module RubyApp

  module Mixins

    module DelegateMixin

      def exists?
        return self.get != nil
      end

      def method_missing(name, *arguments, &block)
        return self.get.send(name, *arguments, &block)
      end

    end

  end

end
