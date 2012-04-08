require 'rubygems'
require 'bundler/setup'

require 'facets/string/interpolate'
require 'securerandom'
require 'thread'

module RubyApp
  require 'ruby_app/mixins'

  class Session
    extend RubyApp::Mixins::ConfigurationMixin
    extend RubyApp::Mixins::DelegateMixin
    extend RubyApp::Mixins::TranslateMixin

    class Identity

      attr_reader :url

      def initialize(url)
        @url = url
      end

    end

    class Test
      extend RubyApp::Mixins::ConfigurationMixin

      def initialize
        @steps = []
        @index = 0
      end

      def empty?
        return @steps.empty?
      end

      def load!(path)
        path = File.join(String.interpolate { RubyApp::Session::Test.configuration.path }, "#{path}.rb")
        Kernel.eval(File.read(path), self.send(:binding), path)
      end

      def step!(_class, name = "Step ##{@steps.length}", &block)
        caller = Kernel.caller.first.split(':')
        @steps.push({:_class => _class,
                     :name  => name,
                     :file => caller[0],
                     :line => caller[1].to_i,
                     :block => block})
      end

      def process?(event)
        return RubyApp::Session::Test.configuration.enabled && @index < @steps.length && event.is_a?(@steps[@index]._class)
      end

      def process!(event)
        begin
          event.process!
          unless self.empty?
            if self.process?(event)
              step = @steps[@index]
              RubyApp::Log.duration("STEP   #{step.name} #{step.file}:#{step.line}") do
                step.block.call(event) if step.block
              end
              @index += 1
              if @index == @steps.length
                RubyApp::Log.debug("STEP   Completed #{@steps.length} steps")
              end
            end
          end
        rescue Exception => exception
          unless self.empty?
            step = @steps[@index]
            RubyApp::Log.error("STEP   Exception occurred at or before #{step.name} #{step.file}:#{step.line}")
            @index = @steps.length
          end
          raise
        end
      end

      def reset!
        @index = 0
      end

    end

    attr_reader :session_id
    attr_reader :expires

    attr_reader :documents
    attr_reader :data

    attr_reader :test

    attr_accessor :identity

    def initialize(document = nil)
      @session_id = RubyApp::Session.generate_session_id(self)
      @expires = Time.now + RubyApp::Session.configuration.expires

      @documents = []
      @data = {}

      @test = RubyApp::Session::Test.new

      @identity = nil

      require 'ruby_app/elements/mobile/default/default_document'
      @documents.push(document || RubyApp::Elements::Mobile::Default::DefaultDocument.new)

    end

    def document
      return @documents.last
    end

    def reset!
      @expires = Time.now + RubyApp::Session.configuration.expires
    end

    def expired?
      return @expires <= Time.now
    end

    def process!(event)
      @test.process!(event)
    end

    def quit!
      RubyApp::Session.lock_sessions do
        RubyApp::Session.sessions.delete(self.session_id)
      end
    end

    def self.sessions
      return @@_sessions ||= {}
    end

    def self.lock_sessions
      ( @@_lock ||= ::Mutex.new ).synchronize do
        yield
      end
    end

    def self.get_session(session_id)
      session = RubyApp::Session.sessions[session_id]
      if session
        unless session.expired?
          session.reset!
          return session
        else
          session.quit!
          return nil
        end
      else
        return nil
      end
    end

    def self.generate_session_id(session)
      session_id = "id_#{SecureRandom.hex(RubyApp::Session.configuration.length)}"
      RubyApp::Session.lock_sessions do
        while RubyApp::Session.get_session(session_id)
          session_id = "id_#{SecureRandom.hex(RubyApp::Session.configuration.length)}"
        end
        RubyApp::Session.sessions.store(session_id, session)
        return session_id
      end
    end

    def self.get
      Thread.current[:_session]
    end

    def self.load!(session_id = nil)
      Thread.current[:_session] = RubyApp::Session.get_session(session_id) || Kernel.eval(RubyApp::Session.configuration._class).new
    end

    def self.unload!
      Thread.current[:_session] = nil
    end

    def self.start_thread!
      unless @@_thread ||= nil
        @@_thread = Thread.new do
          begin
            while true
              RubyApp::Session.sessions.values.each do |session|
                if session.expired?
                  RubyApp::Log.debug("QUIT  #{session.session_id.inspect}")
                  session.quit!
                end
              end
              sleep(RubyApp::Session.configuration.interval)
            end
          rescue Exception => exception
            RubyApp::Log.exception(exception)
          end
        end

        at_exit do
          begin
            RubyApp::Session.stop_thread!
          rescue Exception => exception
            RubyApp::Log.exception(exception)
          end
        end

        RubyApp::Log.debug(RubyApp::Log.prefix(self, __method__))

      end
    end

    def self.stop_thread!
      if @@_thread ||= nil
        RubyApp::Log.debug(RubyApp::Log.prefix(self, __method__))
        @@_thread.exit
        @@_thread = nil
      end
    end

  end

end
