require 'rubygems'
require 'bundler/setup'

require 'ruby_app/session'

module _APPLICATION_UPCODE_

  class Session < RubyApp::Session

    def initialize(session_id, page = nil)
      require '_APPLICATION_DOWNCODE_/elements/pages/default_page'
      super(session_id, page || _APPLICATION_UPCODE_::Elements::Pages::DefaultPage.new)
    end

  end

end
