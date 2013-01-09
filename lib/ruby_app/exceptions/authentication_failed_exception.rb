module RubyApp

  module Exceptions
    require 'ruby_app/exception'

    class AuthenticationFailedException < RubyApp::Exception

      def initialize(message)
        super(message)
      end

    end

  end

end
