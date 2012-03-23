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

    attr_reader :session_id, :expires, :pages, :data
    attr_accessor :identity

    def initialize(page = nil)
      @session_id = RubyApp::Session.generate_session_id(self)
      @expires = Time.now + RubyApp::Session.configuration.expires
      @pages = []
      @dialogs = []
      @data = {}
      @identity = nil

      #require 'ruby_app/elements/pages/default_page'
      #@pages.push(page || RubyApp::Elements::Pages::DefaultPage.new)

      require 'ruby_app/elements/mobile/page'
      @pages.push(page || RubyApp::Elements::Mobile::Page.new)

    end

    def show_dialog(event, dialog, &block)

      @dialogs.push(dialog)

      if block_given? and block.arity == 1
        dialog.shown do |element, _event|
          yield _event
          _event.hide_dialog(element)
        end
      end
      dialog.hidden do |element, _event|
        if block_given? and block.arity == 2
          yield _event, dialog.response
        end
        @dialogs.delete(dialog)
      end

      event.show_dialog(dialog)

    end

    def reset!
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
      session_id = SecureRandom.hex
      RubyApp::Session.lock_sessions do
        while RubyApp::Session.get_session(session_id)
          session_id = SecureRandom.hex
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
              #RubyApp::Log.duration(RubyApp::Log.prefix(self, __method__)) do
                RubyApp::Session.sessions.values.each do |session|
                  if session.expired?
                    #RubyApp::Log.memory(RubyApp::Log.prefix(self, __method__)) do
                      RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} session.quit! #{session.session_id.inspect}")
                      session.quit!
                    #end
                  end
                end
              #end
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
