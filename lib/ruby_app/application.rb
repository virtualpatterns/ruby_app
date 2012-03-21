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

  end

end
