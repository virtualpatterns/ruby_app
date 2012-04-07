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

    class Formatter < ::Logger::Formatter

      def call(severity, time, application, message)
        return "#{severity.ljust(5, ' ')} | #{time.strftime('%Y-%m-%d %H:%M:%S %Z')} | #{Socket.gethostname} | #{RubyApp::Session.exists? ? RubyApp::Session.session_id : '-'} | #{RubyApp::Session.exists? && RubyApp::Session.identity ? RubyApp::Session.identity.url : '-'} | #{message}\n"
      end

    end

    def duration(message)
      start = Time.now
      begin
        return yield if block_given?
      ensure
        self.debug("#{message} #{Time.now - start}s")
      end
    end

    def memory(message)
      begin
        return yield if block_given?
      ensure
        GC.start
        count = ObjectSpace.each_object { |item| }
        self.debug("#{message}  count=#{count}")
        self.debug("#{message} memory=#{`ps -o rss= -p #{$$}`.to_i}")
      end
    end

    def exception(exception)
      self.error('-' * 80)
      self.error("exception=#{exception.class.inspect} #{exception.message}")
      self.error('-' * 80)
      exception.backtrace.each do |line|
        self.error(line)
      end
      self.error('-' * 80)
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
      end
    end

    def self.close!
      if @@_log ||= nil
        @@_log.close
        @@_log = nil
      end
    end

    private

      def initialize(path)
        super(path)
        self.formatter = RubyApp::Log::Formatter.new
      end

  end

end
