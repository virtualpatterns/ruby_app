require 'rubygems'
require 'bundler/setup'

require 'ruby_app'

module _APPLICATION_UPCODE_

  class Session < RubyApp::Session

    def initialize
      require '_APPLICATION_DOWNCODE_/elements/documents/default_document'
      super(_APPLICATION_UPCODE_::Elements::Documents::DefaultDocument.new)
    end

  end

end
