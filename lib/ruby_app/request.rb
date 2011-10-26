require 'rubygems'
require 'bundler/setup'

require 'rack'

module RubyApp
  require 'ruby_app/application'
  require 'ruby_app/mixins/delegate'

  class Request < ::Rack::Request
    extend RubyApp::Mixins::Delegate

    def parameters
      self.params
    end

    def query
      ::Rack::Utils.parse_query(self.query_string)
    end

    def language
      self.fullpath =~ /^\/([^\/\?]+)/
      $1
    end

    def self.get
      Thread.current[:_request]
    end

    def self.create(environment)
      request = RubyApp::Request.new(environment)
      Thread.current[:_request] = request
      if block_given?
        begin
          yield request
        ensure
          Thread.current[:_request] = nil
        end
      end
    end

    def self.destroy
      Thread.current[:_request] = nil
    end

    private

      def initialize(environment)
        super(environment)
      end

  end

end
