require 'rubygems'
require 'bundler/setup'

require 'fileutils'

module RubyApp
  require 'ruby_app/configuration'
  require 'ruby_app/language'
  require 'ruby_app/log'
  require 'ruby_app/mixins/configuration'
  require 'ruby_app/mixins/delegate'
  require 'ruby_app/request'
  require 'ruby_app/session'
  require 'ruby_app/version'

  class Application
    extend RubyApp::Mixins::Delegate
    extend RubyApp::Mixins::Configuration
    include RubyApp::Mixins::Configuration

    attr_reader :options

    def initialize(options)
      @options = options
      @environment = {}

      RubyApp::Log.open(@options[:log_path])
      RubyApp::Configuration.load(@options[:configuration_paths])

    end

    def execute(environment = nil)
      _environment = environment || @environment
      RubyApp::Request.create(_environment) do |request|
        RubyApp::Language.load(RubyApp::Request.language || @options[:default_language], @options[:translations_paths]) do |language|
          RubyApp::Session.create(@options[:session_class]) do |session|
            Thread.current[:_rendered] = {}
            begin
              return yield
            ensure
              Thread.current[:_rendered] = nil
            end
          end
        end
      end
    end

    def self.get
      @@_application
    end

    def self.create(options = {})
      _options = { :application_class => RubyApp::Application,
                   :session_class => RubyApp::Session,
                   :log_path => File.join(RubyApp::ROOT, %w[log application.log]),
                   :configuration_paths => [],
                   :default_language => :en,
                   :translations_paths => [] }.merge(options)
      _options[:configuration_paths] = [File.join(RubyApp::ROOT, %w[config.yml])] + ( _options[:configuration_paths].is_a?(Array) ? _options[:configuration_paths] : [_options[:configuration_paths]] )
      _options[:translations_paths] = [File.join(RubyApp::ROOT, %w[translations])] + ( _options[:translations_paths].is_a?(Array) ? _options[:translations_paths] : [_options[:translations_paths]] )
      @@_application = _options[:application_class].new(_options)
    end

    def self.destroy
      RubyApp::Configuration.unload
      RubyApp::Log.close
      @@_application = nil
    end

  end

end
