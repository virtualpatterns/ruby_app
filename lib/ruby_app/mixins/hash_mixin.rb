module RubyApp

  module Mixins

    module HashMixin

      def method_missing(name, *arguments)
        if name.to_s.match(/(.*)=/)
          capture = $~.captures[0]
          string = capture.to_s
          self[string] = arguments[0] if self.key?(string)
          symbol = capture.to_sym
          self[symbol] = arguments[0] unless self.key?(string)
        else
          self[name.to_s] || self[name.to_sym]
        end
      end

    end

  end

end

class Hash
  include RubyApp::Mixins::HashMixin
end
