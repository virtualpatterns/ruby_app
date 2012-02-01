module RubyApp

  module Mixins

    module HashMixin

      def method_missing(name, *arguments)
        if name.to_s.match(/(.*)=/)
          capture = $~.captures[0]
          self[capture.to_sym] = arguments[0]
        else
          self[name.to_sym]
        end
      end

    end

  end

end

class Hash
  include RubyApp::Mixins::HashMixin

  def symbolize_keys!
    copy=self.dup
    self.clear
    copy.each do |name, value|
      if value.is_a?(Hash)
        value.symbolize_keys!
      end
      self[name.to_sym] = value
    end
    self
  end

end
