module RubyApp

  module Mixins

    module Hash

      def method_missing(name, *arguments)
        if name.to_s.match(/(.*)=/)
          self[$~.captures[0].to_s] = arguments[0]
        else
          self[name.to_s] || self[name.to_sym]
        end
      end

    end

  end

end
