module RubyApp

  module Exceptions
    require 'ruby_app/exception'

    class AssertFailedException < RubyApp::Exception

      def initialize(name)
        super(RubyApp::Exceptions::AssertFailedException.translate.message(name))
      end

    end

  end

end
