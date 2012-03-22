module RubyApp

  module Rack

    class Request
      require 'ruby_app'

      def initialize(application)
        @application = application
      end

      def call(environment)
        RubyApp::Request.create!(environment)
        begin
          #environment.each do |name, value|
          #  RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} environment[#{name.inspect}]=#{value.inspect}")
          #end
          #RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} RubyApp::Request.request_method=#{RubyApp::Request.request_method.inspect}")
          #RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} RubyApp::Request.path=#{RubyApp::Request.path.inspect}")
          return @application.call(environment)
        ensure
          RubyApp::Request.destroy!
        end
      end

    end

  end

end
