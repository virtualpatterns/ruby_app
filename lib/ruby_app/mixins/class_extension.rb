module RubyApp

  module Mixins

    module ClassExtension

      def short_name
        return self.to_s.split('::').last
      end

    end

  end

end

class Class
  include RubyApp::Mixins::ClassExtension
end
