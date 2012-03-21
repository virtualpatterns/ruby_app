require 'rubygems'
require 'bundler/setup'

require 'facets/string/interpolate'
require 'rack'

module RubyApp
  require 'ruby_app/mixins'

  class Response < ::Rack::Response
    extend RubyApp::Mixins::DelegateMixin

    def rendered?(template)
      return @rendered.key?(template)
    end

    def rendered(template)
      @rendered[template] = true
    end

    def content_for(element, name, value = nil, &block)
      @content[element] ||= {}
      @content[element][name] = block_given? ? block : String.interpolate { value }
    end

    def get_content(element, name)
      @content[element] ||= {}
      return @content[element][name]
    end

    def clear_content(element)
      @content[element] = {}
    end

    def self.get
      return Thread.current[:_response]
    end

    def self.create!
      Thread.current[:_response] = RubyApp::Response.new
    end

    def self.destroy!
      Thread.current[:_response] = nil
    end

    private

      def initialize
        super
        self['Cache-Control'] = 'no-cache'
        @rendered = {}
        @content = {}
      end

  end

end
