module RubyApp

  module Rack
    require 'ruby_app'

    class Test

      def initialize(application)
        @application = application
      end

      def call(environment)
        RubyApp::Session.test.load!(RubyApp::Request[:test]) if RubyApp::Request[:test] && RubyApp::Session.test.empty?
        return @application.call(environment)
      end

    end

  end

end
