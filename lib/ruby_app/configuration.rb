require 'yaml'

module RubyApp
  require 'ruby_app/log'
  require 'ruby_app/mixins/delegate'
  require 'ruby_app/mixins/hash'

  class Configuration
    extend RubyApp::Mixins::Delegate

    attr_reader :document

    def self.get
      @@_configuration
    end

    def self.load(configuration_paths)
      @@_configuration = RubyApp::Configuration.new(configuration_paths)
    end

    def self.unload
      @@_configuration = nil
    end

    private

      def initialize(configuration_paths)

        @document = {}

        configuration_paths.each do |path|
          RubyApp::Log.debug("#{self.class}##{__method__}(...) path=#{path.inspect}")
          @document.merge!(YAML::load(File.open(path)))
        end

      end

  end

end

class Hash
  include RubyApp::Mixins::Hash
end
