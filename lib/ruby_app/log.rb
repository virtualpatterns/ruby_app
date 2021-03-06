require 'rubygems'
require 'bundler/setup'

require 'facets/string/interpolate'
require 'fileutils'
require 'logger'
require 'socket'

module RubyApp
  require 'ruby_app'
  require 'ruby_app/mixins'

  class Log < ::Logger
    extend RubyApp::Mixins::ConfigurationMixin
    extend RubyApp::Mixins::DelegateMixin

    attr_reader :path

    class Formatter < ::Logger::Formatter

      def call(severity, time, application, message)
        return "#{severity.ljust(5, ' ')} | #{time.strftime('%Y-%m-%d %H:%M:%S %Z')} | #{Socket.gethostname} | #{Process.pid} | #{RubyApp::Session.exists? ? RubyApp::Session.session_id : '                       '} | #{message}\n"
      end

    end

    def duration(severity, message)
      start = Time.now
      begin
        return yield
      ensure
        self.log(severity, "#{message} #{Time.now - start}s")
      end
    end

    def memory(severity, message)
      begin
        return yield
      ensure
        GC.start
        count = ObjectSpace.each_object { |item| }
        self.log(severity, "#{message} #{count} objects")
      end
    end

    def exception(severity, exception)
      self.log(severity, '-' * 80)
      self.log(severity, "exception=#{exception.class.inspect} #{exception.message}")
      self.log(severity, '-' * 80)
      exception.backtrace.each do |line|
        self.log(severity, line)
      end
      self.log(severity, '-' * 80)
    end

    def self.prefix(object, method)
      return "#{object.is_a?(Class) ? object : object.class}#{object.is_a?(Class) ? '.' : '#'}#{method}"
    end
    
    def self.get
      ( @@_log ||= nil ) || ( @@_standard_log ||= RubyApp::Log.new($stdout) )
    end

    def self.open!
      unless @@_log ||= nil
        path = String.interpolate { RubyApp::Log.configuration.path }
        FileUtils.mkdir_p(File.dirname(path))
        @@_log = RubyApp::Log.new(path)
        RubyApp::Log.debug("LOG       #{RubyApp::Log.prefix(self, __method__)}")
      end
    end

    def self.close!
      if @@_log ||= nil
        RubyApp::Log.debug("LOG       #{RubyApp::Log.prefix(self, __method__)}")
        @@_log.close
        @@_log = nil
      end
    end

    def self.reopen!
      RubyApp::Log.close!
      RubyApp::Log.open!
    end

    private

      def initialize(path)
        super(path)

        self.formatter = RubyApp::Log::Formatter.new

        @path = path

      end

  end

end
