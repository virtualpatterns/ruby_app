module RubyApp

  module Rack
    require 'ruby_app'

    class Duration

      def initialize(application)
        @application = application
      end

      def call(environment)
        RubyApp::Log.duration(RubyApp::Log::DEBUG, RubyApp::Log.prefix(self, __method__)) do
          return @application.call(environment)
        end
      end

    end

  end

end
