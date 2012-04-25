module RubyApp

  module Mixins

    module ClassExtension

      def short_name
        return self.to_s.split('::').last
      end

      def class_name
        name = self.to_s
        name.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
        name.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
        name.gsub!(/(::)/,'_')
        name.downcase!
        return name
      end

    end

  end

end

class Class
  include RubyApp::Mixins::ClassExtension
end
