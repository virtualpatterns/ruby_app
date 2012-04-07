module RubyApp

  module Mixins

    module StringExtension

      def to_b
        return self =~ /(true|t|yes|y|on)/ ? true : false
      end

    end

  end

end

class String
  include RubyApp::Mixins::StringExtension
end
