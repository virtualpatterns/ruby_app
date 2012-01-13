module RubyApp
  require 'ruby_app/configuration'
  require 'ruby_app/log'
  require 'ruby_app/mixins/configure_mixin'
  require 'ruby_app/mixins/delegate_mixin'
  require 'ruby_app/mixins/hash_mixin'
  require 'ruby_app/session'
  require 'ruby_app/version'

  class Application
    extend RubyApp::Mixins::DelegateMixin
    include RubyApp::Mixins::ConfigureMixin

    attr_reader :options, :environment

    def initialize(options)
      @options = options
      @environment = {}
    end

    def start!
      RubyApp::Log.open!
      RubyApp::Configuration.load!
    end

    def stop!
      RubyApp::Configuration.unload!
      RubyApp::Log.close!
    end

    def self.get
      @@_application ||= nil
    end

    def self.create!(options = {})
      _options = { :application_class => RubyApp::Application,
                   :session_class => RubyApp::Session,
                   :log_path => File.join(RubyApp::ROOT, %w[log application.log]),
                   :configuration_paths => [],
                   :default_language => :en,
                   :translations_paths => [] }.merge(options)
      _options.configuration_paths = [File.join(RubyApp::ROOT, %w[config.yml])] + ( _options.configuration_paths.is_a?(Array) ? _options.configuration_paths : [_options.configuration_paths] )
      _options.translations_paths = [File.join(RubyApp::ROOT, %w[translations])] + ( _options.translations_paths.is_a?(Array) ? _options.translations_paths : [_options.translations_paths] )
      @@_application = _options.application_class.new(_options)
      @@_application.start!
    end

    def self.destroy!
      @@_application.stop!
      @@_application = nil
    end

  end

end
