module RubyApp

  module Exceptions
    require 'ruby_app/exceptions/base/base_exception'

    class SessionInvalidException < RubyApp::Exceptions::Base::BaseException

      attr_reader :session_id

      def initialize(session_id)
        super(RubyApp::Exceptions::SessionInvalidException.translate.message)
        @session_id = session_id
      end

    end

  end

end
