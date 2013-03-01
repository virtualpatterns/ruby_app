module RubyApp

  module Rack
    require 'ruby_app'

    class Duration

      def initialize(application, options = {})
        @application = application
        @options = {:interval => 5}.merge(options)
        @count = 0
      end

      def call(environment)
        if @count.modulo(@options[:interval]) == 0
          @count = 1
          RubyApp::Log.duration(RubyApp::Log::INFO, 'DURATION  ') do
            return @application.call(environment)
          end
        else
          @count += 1
          return @application.call(environment)
        end
      end

    end

  end

end
