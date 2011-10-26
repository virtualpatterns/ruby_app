module RubyApp

  module Mixins

    module Delegate

      def method_missing(name, *arguments, &block)
        self.get.send(name, *arguments, &block)
      end

    end

  end

end
