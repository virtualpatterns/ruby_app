#\ --port 8000 --pid ./rack.pid
# Placeholder for template application LOAD_PATH.unshift ...

require 'rubygems'
require 'bundler/setup'

require 'rack'

require 'ruby_app'
require 'ruby_app/rack'

# Placeholder for template application require

RubyApp::Application.root = '/'

use Rack::ShowExceptions
use Rack::Reloader

#use RubyApp::Rack::Duration
#use RubyApp::Rack::Memory

use RubyApp::Rack::Application, :configuration_paths  => [File.join(RubyApp::ROOT, %w[configuration.yml])]
# Placeholder for template application configuration path

map "#{RubyApp::Application.root_or_nil}/ruby_app/resources" do
  run Rack::File.new(File.join(RubyApp::ROOT, %w[resources]))
end

# Placeholder for template application resources



map "#{RubyApp::Application.root_or_nil}/favicon.ico" do
  run Rack::File.new(File.join(RubyApp::ROOT, %w[resources favicon.ico]))
end

map "#{RubyApp::Application.root_or_nil}/" do
  use RubyApp::Rack::Request
  use RubyApp::Rack::Response
  use RubyApp::Rack::Language
  use RubyApp::Rack::Session
  run RubyApp::Rack::Route.new
end
