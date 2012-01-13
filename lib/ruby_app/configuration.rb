require 'yaml'

module RubyApp
  require 'ruby_app/application'
  require 'ruby_app/log'
  require 'ruby_app/mixins/delegate_mixin'
  require 'ruby_app/mixins/hash_mixin'

  class Configuration
    extend RubyApp::Mixins::DelegateMixin

    attr_reader :document

    def self.get
      @@_configuration
    end

    def self.load!
      @@_configuration = RubyApp::Configuration.new(RubyApp::Application.options.configuration_paths)
    end

    def self.unload!
      @@_configuration = nil
    end

    private

      def initialize(paths)
        @document = {}
        paths.each do |path|
          @document.merge!(YAML::load(File.open(path)))
        end
      end

  end

end
