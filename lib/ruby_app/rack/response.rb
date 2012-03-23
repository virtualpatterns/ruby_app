module RubyApp

  module Rack
    require 'ruby_app'

    class Response

      def initialize(application)
        @application = application
      end

      def call(environment)
        RubyApp::Response.create!
        begin
          @application.call(environment)
          return RubyApp::Response.finish
        ensure
          RubyApp::Response.destroy!
        end
      end

    end

  end

end
