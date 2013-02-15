require 'rubygems'
require 'bundler/setup'

require 'rack'

module RubyApp
  require 'ruby_app/mixins'

  class Request < ::Rack::Request
    extend RubyApp::Mixins::DelegateMixin

    attr_reader :environment

    def language
      self.path.gsub(/^#{RubyApp.root_or_nil}/,'') =~ /^\/([^\/\?]+)/
      return $1
    end

    def query
      return ::Rack::Utils.parse_query(self.query_string)
    end

    def parameters
      return self.params
    end

    def self.get
      return Thread.current[:_request]
    end

    def self.exists?
      return Thread.current[:_request]
    end

    def self.create!(environment = RubyApp::Application.environment)
      return Thread.current[:_request] = RubyApp::Request.new(environment)
    end

    def self.destroy!
      return Thread.current[:_request] = nil
    end

    def self.create_context!
      unless RubyApp::Request.exists?
        RubyApp::Request.create!
        RubyApp::Response.create!
        RubyApp::Language.load!
        RubyApp::Session.load!
        begin
          yield
        ensure
          RubyApp::Session.unload!
          RubyApp::Language.unload!
          RubyApp::Response.destroy!
          RubyApp::Request.destroy!
        end
      end
    end

    private

      def initialize(environment)
        super(environment)
        @environment = environment
      end

  end

end
