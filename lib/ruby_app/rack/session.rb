module RubyApp

  module Rack
    require 'ruby_app'

    class Session

      def initialize(application)
        @application = application
      end

      def call(environment)
        RubyApp::Session.load!(RubyApp::Request.cookies['_session'], RubyApp::Request.query['steps'])
        begin
          #RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} RubyApp::Session.session_id=#{RubyApp::Session.session_id.inspect}")
          #RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} RubyApp::Session.expires=#{RubyApp::Session.expires.inspect}")
          #RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)}                    (now)=#{Time.now.inspect}")
          RubyApp::Response.set_cookie('_session', { :value    => RubyApp::Session.session_id,
                                                     :expires  => RubyApp::Session.expires,
                                                     :path     => '/'})
          return @application.call(environment)
        ensure
          RubyApp::Session.unload!
        end
      end

    end

  end

end
