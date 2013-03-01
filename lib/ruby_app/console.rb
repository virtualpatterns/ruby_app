require 'rubygems'
require 'bundler/setup'

require 'ruby_app'

# Placeholder for template application LOAD_PATH.unshift ...

# Placeholder for template application require

RubyApp::Configuration.load!([File.join(RubyApp::ROOT, %w[configuration.yml])])
# Placeholder for template application configuration
RubyApp::Log.open!
RubyApp::Application.create!

Signal.trap('HUP') do
  begin
    RubyApp::Log.reopen!
  rescue => exception
    RubyApp::Log.exception(RubyApp::Log::ERROR, exception)
  end
end

Signal.trap('EXIT') do
  begin
    RubyApp::Application.destroy!
    RubyApp::Log.close!
    RubyApp::Configuration.unload!
  rescue => exception
    RubyApp::Log.exception(RubyApp::Log::ERROR, exception)
  end
end

