require 'logger'

module RubyApp
  require 'ruby_app/mixins/delegate'

  class Log < ::Logger
    extend RubyApp::Mixins::Delegate

    def self.get
      @@_logger
    end

    def self.open(path)
      directory = File.dirname(path)
      Dir.mkdir(directory) unless File.exists?(directory)
      @@_logger = RubyApp::Log.new(path)
      @@_logger.debug("#{self}##{__method__} path=#{path.inspect}")
    end

    def self.close
      @@_logger.close
      @@_logger = nil
    end

    private

      def initialize(path)
        super(path)
      end

  end

end
