module RubyApp

  module Rack
    require 'ruby_app'

    class Language

      def initialize(application)
        @application = application
      end

      def call(environment)
        RubyApp::Language.load!(RubyApp::Request.language)
        begin
          #RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} RubyApp::Language.locale.code=#{RubyApp::Language.locale.code.inspect}")
          return @application.call(environment)
        ensure
          RubyApp::Language.unload!
        end
      end

    end

  end

end
