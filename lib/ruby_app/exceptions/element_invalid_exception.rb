module RubyApp

  module Exceptions
    require 'ruby_app/exception'

    class ElementInvalidException < RubyApp::Exception

      def initialize(element_id)
        super(RubyApp::Exceptions::ElementInvalidException.translate.message)
      end

    end

  end

end
