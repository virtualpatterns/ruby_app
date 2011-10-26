require 'rubygems'
require 'bundler/setup'

require 'r18n-core'

module RubyApp
  require 'ruby_app/mixins/delegate'

  class Language < R18n::I18n
    extend RubyApp::Mixins::Delegate

    def reload
      R18n.get.reload!
    end

    def self.get
      R18n.get
    end

    def self.load(language, translations_paths)
      language = RubyApp::Language.new(language, translations_paths)
      R18n.thread_set(language)
      if block_given?
        begin
          yield language
        ensure
          R18n.thread_set(nil)
        end
      end
    end

    def self.unload
      R18n.thread_set(nil)
    end

    private

      def initialize(language, translations_paths)
        super(language, translations_paths)
      end

  end

end
