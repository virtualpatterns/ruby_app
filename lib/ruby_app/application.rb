require 'rubygems'
require 'bundler/setup'

require 'fileutils'

module RubyApp
  require 'ruby_app/mixins'

  class Application
    extend RubyApp::Mixins::ConfigurationMixin
    extend RubyApp::Mixins::DelegateMixin

    attr_reader :options, :environment

    def initialize
      @environment = {}
    end

    def self.get
      @@_application ||= nil
    end

    def self.create!
      @@_application = ( Kernel.eval(RubyApp::Application.configuration._class) ).new
    end

    def self.destroy!
      @@_application = nil
    end

    def self.create_context!(configuration_paths = [File.join(RubyApp::ROOT, %w[configuration.yml])])
      RubyApp::Configuration.load!(configuration_paths)
      RubyApp::Log.open!
      RubyApp::Application.create!
      begin
        yield
      ensure
        RubyApp::Application.destroy!
        RubyApp::Log.close!
        RubyApp::Configuration.unload!
      end
    end

  end

end
