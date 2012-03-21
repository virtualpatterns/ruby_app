module RubyApp

  module Mixins

    module TranslateMixin
      require 'ruby_app'

      def translate

        name = self.is_a?(Class) ? self.to_s : self.class.to_s
        name.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
        name.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
        name.tr!("-", "_")
        name.downcase!

        names = name.split('::')

        value = RubyApp::Language.t
        names.each do |name|
          value = value[name]
        end

        return value

      end

      def localize(*parameters)
        RubyApp::Language.l(*parameters)
      end

    end

  end

end
