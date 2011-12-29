require 'logger'

module RubyApp
  require 'ruby_app/application'
  require 'ruby_app/mixins/delegate_mixin'

  class Log < ::Logger
    extend RubyApp::Mixins::DelegateMixin

    def exception(exception)
      self.error('-' * 80)
      self.error("exception=#{exception.class.inspect} #{exception.message}")
      self.error('-' * 80)
      exception.backtrace.each do |line|
        self.error(line)
      end
      self.error('-' * 80)
    end

    def self.get
      @@_log
    end

    def self.open!
      path = RubyApp::Application.options.log_path
      directory = File.dirname(path)
      Dir.mkdir(directory) unless File.exists?(directory)
      @@_log = RubyApp::Log.new(path)
      @@_log.debug("#{self}##{__method__} path=#{path.inspect}")
    end

    def self.close!
      @@_log.debug("#{self}##{__method__}")
      @@_log.close if @@_log
      @@_log = nil
    end

    private

      def initialize(path)
        super(path)
      end

  end

end
