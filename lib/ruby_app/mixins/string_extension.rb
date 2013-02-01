module RubyApp

  module Mixins

    module StringExtension

      def to_b
        return self =~ /(true|t|yes|y|on)/ ? true : false
      end

      def to_class
        _class = Object
        self.split('::').each do |name|
          _class = _class.const_get(name)
        end
        return _class
      end

    end

  end

end

class String
  include RubyApp::Mixins::StringExtension
end
