module RubyApp
  require 'ruby_app/mixins'

  class Exception < ::RuntimeError
    extend RubyApp::Mixins::TranslateMixin

    def initialize(message)
      super(message)
    end

  end

end
