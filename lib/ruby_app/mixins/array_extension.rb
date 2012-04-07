module RubyApp

  module Mixins

    module ArrayExtension

      def second_last
        self.length > 1 ?  self[self.length - 2] : nil
      end

    end

  end

end

class Array
  include RubyApp::Mixins::ArrayExtension
end
