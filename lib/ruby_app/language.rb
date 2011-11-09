require 'rubygems'
require 'bundler/setup'

require 'r18n-core'

module RubyApp
  require 'ruby_app/application'
  require 'ruby_app/mixins/delegate_mixin'
  require 'ruby_app/request'

  class Language < R18n::I18n
    extend RubyApp::Mixins::DelegateMixin

    def self.get
      R18n.get
    end

    def self.load!
      R18n.thread_set(RubyApp::Language.new(RubyApp::Request.language, RubyApp::Application.options.translations_paths))
      if block_given?
        begin
          yield
        ensure
          self.unload!
        end
      end
    end

    def self.unload!
      R18n.thread_set(nil)
    end

    private

      def initialize(language, translations_paths)
        super(language, translations_paths)
      end

  end

end
