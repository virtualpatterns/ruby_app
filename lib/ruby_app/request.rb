require 'rubygems'
require 'bundler/setup'

require 'rack'

module RubyApp
  require 'ruby_app/mixins'

  class Request < ::Rack::Request
    extend RubyApp::Mixins::DelegateMixin

    def language
      self.fullpath =~ /^\/([^\/\?]+)/
      return $1
    end

    def query
      ::Rack::Utils.parse_query(self.query_string)
    end

    def parameters
      self.params
    end

    def quit?
      self.path =~ /\/quit/
    end

    def self.get
      Thread.current[:_request]
    end

    def self.create!(environment = RubyApp::Application.environment)
      Thread.current[:_request] = RubyApp::Request.new(environment)
    end

    def self.destroy!
      Thread.current[:_request] = nil
    end

    private

      def initialize(environment)
        super(environment)
      end

  end

end
