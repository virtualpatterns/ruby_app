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
      end

      def call(environment)
        return @application.call(environment)
      end

    end

  end

end
