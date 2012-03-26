require 'rubygems'
require 'bundler/setup'

require 'facets/string/interpolate'
require 'rack'

module RubyApp
  require 'ruby_app/mixins'

  class Response < ::Rack::Response
    extend RubyApp::Mixins::DelegateMixin
    extend RubyApp::Mixins::ConfigurationMixin

    def rendered?(template)
      return @rendered.key?(template)
    end

    def rendered(template)
      @rendered[template] = true
    end

    def content_for(element, format, name, value = nil, &block)
      @content[element] ||= {}
      @content[element][name] = block_given? ? block : String.interpolate { value }
    end

    def get_content(element, format, name)
      @content[element] ||= {}
      return @content[element][name]
    end

    def write_from_cache(element, format)
      if RubyApp::Response.configuration.cache.formats.include?(format)
        cache = element.cache(format)
        if RubyApp::Response.configuration.cache.read? && File.exists?(cache)
          RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} READ  #{cache.inspect}")
          self.write(File.read(cache))
        else
          content = element.render(format)
          if RubyApp::Response.configuration.cache.write? && !File.exists?(cache)
            FileUtils.mkdir_p(File.dirname(cache))
            RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} WRITE #{cache.inspect}")
            File.open(cache, 'w') do |file|
              file.write(content)
              file.flush
            end
          end
          self.write(content)
        end
      else
        self.write(element.render(format))
      end
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
