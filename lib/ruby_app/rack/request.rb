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
          # RubyApp::Request.environment.each do |name, value|
          #   RubyApp::Log.debug("REQUEST   RubyApp::Request.environment[#{name.inspect}]=#{value.inspect}")
          # end
          # RubyApp::Log.debug("REQUEST   RubyApp::Request.path=#{RubyApp::Request.path.inspect}")
          # RubyApp::Log.debug("REQUEST   RubyApp::Request.language=#{RubyApp::Request.language.inspect}")
          # RubyApp::Log.debug("REQUEST   RubyApp::Request.url=#{RubyApp::Request.url.inspect}")
          # RubyApp::Log.debug("REQUEST   RubyApp::Request.query=#{RubyApp::Request.query.inspect}")
          # RubyApp::Request.query.each do |name, value|
          #   RubyApp::Log.debug("REQUEST   RubyApp::Request.query[#{name.inspect}]=#{value.inspect}")
          # end
          return @application.call(environment)
        ensure
          RubyApp::Request.destroy!
        end
      end

    end

  end

end
