require 'rubygems'
require 'bundler/setup'

require 'ruby_app'

module _APPLICATION_UPCODE_

  class Session < RubyApp::Session

    def initialize
      require '_APPLICATION_DOWNCODE_/elements/pages/default_page'
      super(_APPLICATION_UPCODE_::Elements::Pages::DefaultPage.new)
    end

  end

end
