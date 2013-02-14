module RubyApp

  module Rack
    require 'ruby_app'

    class Request

      def initialize(application)
        @application = application
      end

      def call(environment)
        RubyApp::Request.create!(environment)
        begin
          #RubyApp::Request.environment.each do |name, value|
          #  RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} RubyApp::Request.environment[#{name.inspect}]=#{value.inspect}")
          #end
          #RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} RubyApp::Request.request_method=#{RubyApp::Request.request_method.inspect}")
          # RubyApp::Log.debug("REQUEST   RubyApp::Request.path=#{RubyApp::Request.path.inspect}")
          RubyApp::Log.debug("REQUEST   RubyApp::Request.url=#{RubyApp::Request.url.inspect}")
          RubyApp::Log.debug("REQUEST   RubyApp::Request.query_string=#{RubyApp::Request.query_string.inspect}")
          #RubyApp::Request.query.each do |name, value|
          #  RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} RubyApp::Request.query[#{name.inspect}]=#{value.inspect}")
          #end
          return @application.call(environment)
        ensure
          RubyApp::Request.destroy!
        end
      end

    end

  end

end
