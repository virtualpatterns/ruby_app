require 'yaml'

module RubyApp
  require 'ruby_app/mixins/delegate_mixin'
  require 'ruby_app/mixins/hash_mixin'

  class Configuration
    extend RubyApp::Mixins::DelegateMixin

    attr_reader :document

    def self.get
      @@_configuration
    end

    def self.load!(paths)
      @@_configuration = RubyApp::Configuration.new(paths)
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
