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
          RubyApp::Log.debug("LANGUAGE  #{RubyApp::Language.locale.code}")
          return @application.call(environment)
        ensure
          RubyApp::Language.unload!
        end
      end

    end

  end

end
