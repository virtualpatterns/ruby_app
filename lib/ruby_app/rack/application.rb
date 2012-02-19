module RubyApp

  module Rack
    require 'ruby_app/application'
    require 'ruby_app/log'
    require 'ruby_app/request'

    class Application

      def initialize(application, options = {})
        @application = application
        RubyApp::Application.create!(options)
      end

      def call(environment)
        RubyApp::Request.create!(environment) do
          return @application.call(environment)
        end
      end

    end

  end

end
