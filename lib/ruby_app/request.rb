require 'rubygems'
require 'bundler/setup'

require 'facets/string/interpolate'
require 'rack'

module RubyApp
  require 'ruby_app/application'
  require 'ruby_app/language'
  require 'ruby_app/mixins/delegate_mixin'
  require 'ruby_app/mixins/render_mixin'
  require 'ruby_app/session'

  class Request < ::Rack::Request
    extend RubyApp::Mixins::DelegateMixin

    def language
      self.fullpath =~ /^\/([^\/\?]+)/
      $1 || RubyApp::Application.options.default_language
    end

    def query
      ::Rack::Utils.parse_query(self.query_string)
    end

    def parameters
      self.params
    end

    def rendered?(template)
      @rendered.key?(template)
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
      @content[element] ||= {}
    end

    def self.get
      Thread.current[:_request]
    end

    def self.create!(environment = RubyApp::Application.environment)
      Thread.current[:_request] = RubyApp::Request.new(environment)

      if block_given?
        begin
          RubyApp::Language.load! do
            RubyApp::Session.create! do
              return yield
            end
          end
        ensure
          self.destroy!
        end
      else
        begin
          RubyApp::Language.load!
          begin
            RubyApp::Session.create!
          rescue
            RubyApp::Language.unload!
            raise
          end
        rescue
          self.destroy!
          raise
        end
      end

    end

    def self.destroy!
      Thread.current[:_request] = nil
    end

    private

      def initialize(environment)
        super(environment)
        @rendered = {}
        @content = {}
      end

  end

end
