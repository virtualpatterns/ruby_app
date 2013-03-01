require 'rubygems'
require 'bundler/setup'

require 'ruby_app'

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), %w[lib]))

require '_APPLICATION_DOWNCODE_'

RubyApp::Configuration.load!([ File.join(RubyApp::ROOT, %w[configuration.yml]),
                               File.join(_APPLICATION_UPCODE_::ROOT, %w[configuration.yml])])
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

