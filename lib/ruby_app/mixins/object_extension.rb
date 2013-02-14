module RubyApp

  module Mixins

    module ObjectExtension

      def nil_if(value)
        return self == value ? nil : self
      end

    end

  end

end

class Object
  include RubyApp::Mixins::ObjectExtension
end
