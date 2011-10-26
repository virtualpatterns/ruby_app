module RubyApp
  require 'ruby_app/mixins/configuration'
  require 'ruby_app/mixins/delegate'
  require 'ruby_app/mixins/translate'
  require 'ruby_app/request'

  class Session
    extend RubyApp::Mixins::Delegate
    include RubyApp::Mixins::Hash
    extend RubyApp::Mixins::Configuration
    include RubyApp::Mixins::Configuration
    extend RubyApp::Mixins::Translate

    class Identity
      include RubyApp::Mixins::Hash

      attr_reader :url

      def initialize(url, data = {})
        @url = url
        @data = data
      end

      def [](key)
        @data[key]
      end

    end

    attr_reader :pages, :data
    attr_accessor :identity

    def initialize(page = nil)
      require 'ruby_app/elements/pages/default_page'
      @pages = [page || RubyApp::Elements::Pages::DefaultPage.new]
      @dialogs = []
      @identity = nil
      @data = {}
    end

    def [](key)
      @data[key]
    end

    def []=(key, value)
      @data[key] = value
    end

    def show(event, dialog, &block)

      @dialogs.push(dialog)

      if block_given? and block.arity == 1
        dialog.shown do |element, _event|
          yield _event
          _event.hide(element)
        end
      end
      dialog.hidden do |element, _event|
        if block_given? and block.arity == 2
          yield _event, dialog.response
        end
        @dialogs.delete(dialog)
      end

      event.show(dialog)

    end

    def process(event)
      event.source.send(:on_event, event)
    end

    def quit
      RubyApp::Request.env['rack.session.options'][:drop] = true
    end

    def self.get
      Thread.current[:_session]
    end

    def self.create(_class)
      session = RubyApp::Request.session[:_session] || _class.new
      RubyApp::Request.session[:_session] = session
      Thread.current[:_session] = session
      if block_given?
        begin
          yield session
        ensure
          Thread.current[:_session] = nil
        end
      end
    end

    def self.destroy
      Thread.current[:_session] = nil
    end

  end

end
