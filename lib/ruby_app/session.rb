module RubyApp
  require 'ruby_app/application'
  require 'ruby_app/log'
  require 'ruby_app/mixins/configuration_mixin'
  require 'ruby_app/mixins/delegate_mixin'
  require 'ruby_app/mixins/hash_mixin'
  require 'ruby_app/mixins/translate_mixin'
  require 'ruby_app/request'

  class Session
    extend RubyApp::Mixins::DelegateMixin
    include RubyApp::Mixins::HashMixin
    include RubyApp::Mixins::ConfigurationMixin
    extend RubyApp::Mixins::TranslateMixin

    class Identity

      attr_reader :url

      def initialize(url)
        @url = url
      end

    end

    attr_reader :session_id, :pages, :data
    attr_accessor :identity

    def initialize(session_id, page = nil, data = {})
      @session_id = session_id
      @pages = []
      @dialogs = []
      @data = data
      @identity = nil

      require 'ruby_app/elements/pages/default_page'
      @pages.push(page || RubyApp::Elements::Pages::DefaultPage.new)

      RubyApp::Log.memory("#{self.class}##{__method__}")

    end

    def [](key)
      @data[key]
    end

    def []=(key, value)
      @data[key] = value
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

    def quit
      RubyApp::Request.env['rack.session.options'][:drop] = true if RubyApp::Request.env['rack.session.options']
    end

    def self.get
      Thread.current[:_session]
    end

    def self.create!
      RubyApp::Request.session[:_initialize] = true
      Thread.current[:_session] = RubyApp::Request.session[:_session] ||= RubyApp::Application.options.session_class.new(RubyApp::Request.env['rack.session.options'] ? RubyApp::Request.env['rack.session.options'][:id] : nil)
      if block_given?
        begin
          yield
        ensure
          self.destroy!
        end
      end
    end

    def self.destroy!
      Thread.current[:_session] = nil
    end

  end

end
