module RubyApp

  module Rack
    require 'ruby_app'

    class Application

      def initialize(application, options = {})
        @application = application
        RubyApp::Configuration.load!(options[:configuration_paths])
        RubyApp::Log.open!
        RubyApp::Application.create!
        RubyApp::Session.start_thread!

        Signal.trap('HUP') do
          begin
            RubyApp::Log.reopen!
          rescue => exception
            RubyApp::Log.exception(RubyApp::Log::ERROR, exception)
          end
        end

        Signal.trap('EXIT') do
          begin
            RubyApp::Session.stop_thread!
          rescue => exception
            RubyApp::Log.exception(RubyApp::Log::ERROR, exception)
          end
        end

      end

      def call(environment)
        return @application.call(environment)
      end

    end

  end

end
