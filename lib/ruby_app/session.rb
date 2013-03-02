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

      attr_reader :uri

      def initialize(uri)
        @uri = uri
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

    def load_script!(path)
      _path = File.join(String.interpolate { RubyApp::Session.configuration.scripts.path }, "#{path}.rb")
      Kernel.eval(File.read(_path), self.send(:binding), _path)
    end

    def add_step!(_class, &block)
      caller = Kernel.caller.first.split(':')
      @steps.push({:_class => _class,
                   :file => caller[0].gsub(String.interpolate { RubyApp::Session.configuration.scripts.path }, '').gsub(/^\//, ''),
                   :line => caller[1].to_i,
                   :block => block})
    end

    def process_event!(event)

      event.process!

      if RubyApp::Session.configuration.scripts.enabled
        step = @steps[@steps_index]
        if step
          begin
            if event.is_a?(step._class)
              @steps_index += 1
              RubyApp::Log.duration(RubyApp::Log::INFO, "STEP      Current #{step._class} #{step.file}:#{step.line}#{step.block ? nil : ' (no block)'}") do
                step.block.call(event) if step.block
              end
              if @steps_index == @steps.length
                RubyApp::Log.info('-' * 80)
                RubyApp::Log.info("STEP      Completed #{@steps.length} steps")
                RubyApp::Log.info('-' * 80)
                event.alert("Completed #{@steps.length} steps.")
              else
                step = @steps[@steps_index]
                RubyApp::Log.info("STEP      Next    #{step._class} #{step.file}:#{step.line}#{step.block ? nil : ' (no block)'}")
              end
            end
          rescue => exception
            RubyApp::Log.info("STEP      Exception occurred at #{step.file}:#{step.line}")
            @steps_index = @steps.length
            raise
          end
        end
      end

    end

    def reset_script!
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
      session_id = "id_#{SecureRandom.hex(RubyApp::Session.configuration._length)}"
      RubyApp::Session.lock_sessions do
        while RubyApp::Session.get_session(session_id)
          session_id = "id_#{SecureRandom.hex(RubyApp::Session.configuration._length)}"
        end
        RubyApp::Session.sessions.store(session_id, session)
        return session_id
      end
    end

    def self.get
      Thread.current[:_session]
    end

    def self.load!(session_id = nil, script_path = nil)
      session = RubyApp::Session.get_session(session_id)
      unless session
        session = Kernel.eval(RubyApp::Session.configuration._class).new
        session.load_script!(script_path) if script_path
        RubyApp::Log.debug("SESSION   RubyApp::Session.session_id=#{session.session_id.inspect}")
        RubyApp::Session.configuration.log.each do |variable|
          RubyApp::Log.debug("SESSION   RubyApp::Request.environment['#{variable}']=#{RubyApp::Request.environment[variable].inspect}")
        end
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
                  RubyApp::Log.debug("SESSION   session.session_id=#{session.session_id.inspect}")
                  RubyApp::Log.debug("SESSION   session.quit!")
                  session.quit!
                end
              end
              sleep(RubyApp::Session.configuration.interval)
            end
          rescue => exception
            RubyApp::Log.exception(RubyApp::Log::ERROR, exception)
          end
        end

        RubyApp::Log.debug("SESSION   #{RubyApp::Log.prefix(self, __method__)}")

      end
    end

    def self.stop_thread!
      if @@_thread ||= nil
        RubyApp::Log.debug("SESSION   #{RubyApp::Log.prefix(self, __method__)}")
        @@_thread.exit
        @@_thread = nil
      end
    end

    def self.get_scripts(path = String.interpolate { RubyApp::Session.configuration.scripts.path })
      scripts = []
      Dir.new(path).each do |item|
        unless item.start_with?('.')
          _path = File.join(path, item)
          if File.directory?(_path)
            scripts += self.get_scripts(_path)
          elsif _path =~ /\.rb/
            name = _path.gsub(String.interpolate { RubyApp::Session.configuration.scripts.path }, '').gsub(/^\//, '').gsub(/\.rb/, '')
            scripts.push({:name => name,
                          :url  => "#{RubyApp::Application.root_or_nil}/quit?go=#{CGI.escape("#{RubyApp::Application.root}?script=#{name}")}"})
          end
        end
      end
      return scripts.sort { |a, b| a.name <=> b.name }
    end

  end

end
