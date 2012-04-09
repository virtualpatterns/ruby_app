require 'rubygems'
require 'bundler/setup'

require 'facets/string/interpolate'
require 'securerandom'
require 'thread'

module RubyApp
  require 'ruby_app/log'
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

    attr_reader :session_id
    attr_reader :expires

    attr_reader :documents
    attr_reader :data

    attr_accessor :identity

    def initialize(document = nil)
      @session_id = RubyApp::Session.generate_session_id(self)
      @expires = Time.now + RubyApp::Session.configuration.expires

      @documents = []
      @data = {}

      @identity = nil

      @steps = []
      @steps_index = 0

      require 'ruby_app/elements/mobile/default/default_document'
      @documents.push(document || RubyApp::Elements::Mobile::Default::DefaultDocument.new)

    end

    def document
      return @documents.last
    end

    def reset_expiry!
      @expires = Time.now + RubyApp::Session.configuration.expires
    end

    def expired?
      return @expires <= Time.now
    end

    def quit!
      RubyApp::Session.lock_sessions do
        RubyApp::Session.sessions.delete(self.session_id)
      end
    end

    def load_steps!(path)
      path = File.join(String.interpolate { RubyApp::Session::configuration.steps.path }, "#{path}.rb")
      #RubyApp::Log.duration(RubyApp::Log::DEBUG, "#{RubyApp::Log.prefix(self, __method__)} path=#{path.inspect}") do
        Kernel.eval(File.read(path), self.send(:binding), path)
      #end
    end

    def add_step!(_class, name = "Step ##{@steps.length}", &block)
      caller = Kernel.caller.first.split(':')
      @steps.push({:_class => _class,
                   :name  => name,
                   :file => caller[0],
                   :line => caller[1].to_i,
                   :block => block})
    end

    def process_event!(event)

      event.process!

      if RubyApp::Session.configuration.steps.enabled
        step = @steps[@steps_index]
        if step && event.is_a?(step._class)
          begin
            RubyApp::Log.duration(RubyApp::Log::INFO, "STEP   #{step.name} #{step.file}:#{step.line}") do
              step.block.call(event)
            end
            @steps_index += 1
            if @steps_index == @steps.length
              RubyApp::Log.info("STEP   Completed #{@steps.length} steps")
            end
          rescue Exception => exception
            RubyApp::Log.info("STEP   Exception occurred at #{step.name} #{step.file}:#{step.line}")
            @steps_index = @steps.length
            raise
          end
        end
      end

    end

    def reset_steps!
      @steps_index = 0
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
          session.reset_expiry!
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

    def self.load!(session_id = nil, steps_path = nil)
      session = RubyApp::Session.get_session(session_id)
      unless session
        session = Kernel.eval(RubyApp::Session.configuration._class).new
        session.load_steps!(steps_path) if steps_path
      end
      Thread.current[:_session] = session
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
            RubyApp::Log.exception(RubyApp::Log::ERROR, exception)
          end
        end

        at_exit do
          begin
            RubyApp::Session.stop_thread!
          rescue Exception => exception
            RubyApp::Log.exception(RubyApp::Log::ERROR, exception)
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
