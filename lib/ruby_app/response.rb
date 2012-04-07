require 'rubygems'
require 'bundler/setup'

require 'facets/string/interpolate'
require 'mime/types'
require 'rack'

module RubyApp
  require 'ruby_app/mixins'

  class Response < ::Rack::Response
    extend RubyApp::Mixins::DelegateMixin
    extend RubyApp::Mixins::ConfigurationMixin

    def rendered?(element, template)
      return element.is_a?(Class) && @templates.include?(template)
    end

    def rendered(element, template)
      @templates.push(template) if element.is_a?(Class) unless @templates.include?(template)
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
        cache = element.get_cache(format)
        if RubyApp::Response.configuration.cache.read? && File.exists?(cache)
          #RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} READ  #{cache.inspect}")
          self.write(File.read(cache))
        else
          content = element.render(format)
          if RubyApp::Response.configuration.cache.write? && !File.exists?(cache)
            FileUtils.mkdir_p(File.dirname(cache))
            #RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} WRITE #{cache.inspect}")
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

    def self.get_content_type(format)
      return ( mime_type = MIME::Types.type_for(format)[0] ) ? mime_type.content_type : 'text/plain'
    end

    private

      def initialize
        super
        self['Cache-Control'] = 'no-cache'
        @templates = []
        @content = {}
      end

  end

end
