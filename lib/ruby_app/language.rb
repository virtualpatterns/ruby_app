require 'rubygems'
require 'bundler/setup'

require 'facets/string/interpolate'
require 'r18n-core'

module RubyApp
  require 'ruby_app/mixins'

  class Language < R18n::I18n
    extend RubyApp::Mixins::ConfigurationMixin
    extend RubyApp::Mixins::DelegateMixin

    def self.get
      return R18n.get
    end

    def self.load!(language = nil)
      paths = RubyApp::Language.configuration.paths.collect { |path| String.interpolate { path } }
      R18n.thread_set(RubyApp::Language.new(language || RubyApp::Language.configuration.default, paths))
    end

    def self.unload!
      R18n.thread_set(nil)
    end

    private

      def initialize(language, paths)
        super(language, paths)
      end

  end

end
