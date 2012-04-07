module RubyApp
  require 'ruby_app/mixins'

  class Exception < ::Exception
    extend RubyApp::Mixins::TranslateMixin

    def initialize(message)
      super(message)
    end

  end

end
