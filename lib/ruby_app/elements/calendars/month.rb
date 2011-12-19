require 'rubygems'
require 'bundler/setup'

require 'ruby-event'

module RubyApp

  module Elements

    module Calendars
      require 'ruby_app/elements/calendars/base/base_month'

      class Month < RubyApp::Elements::Calendars::Base::BaseMonth

        template_path(:all, File.dirname(__FILE__))

        def initialize(today = Date.today, display = nil, value = nil)
          super
        end

      end

    end

  end

end
