module RubyApp

  module Exceptions
    require 'ruby_app/exception'

    class SessionInvalidException < RubyApp::Exception

      def initialize(session_id)
        super(RubyApp::Exceptions::SessionInvalidException.translate.message)
      end

    end

  end

end
