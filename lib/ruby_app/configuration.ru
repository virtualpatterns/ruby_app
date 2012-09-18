#\ --port 8000 --pid ./rack.pid
require 'rubygems'
require 'bundler/setup'

require 'rack'

require 'ruby_app'
require 'ruby_app/rack'

use Rack::ShowExceptions
use Rack::Reloader

#use RubyApp::Rack::Duration
#use RubyApp::Rack::Memory

use RubyApp::Rack::Application, :configuration_paths  => [File.join(RubyApp::ROOT, %w[configuration.yml])]

map '/ruby_app/resources' do
  run Rack::File.new(File.join(RubyApp::ROOT, %w[resources]))
end

map '/google_button.ico' do
  run Rack::File.new(File.join(RubyApp::ROOT, %w[resources google_button.ico]))
end

map '/' do
  use RubyApp::Rack::Request
  use RubyApp::Rack::Response
  use RubyApp::Rack::Language
  use RubyApp::Rack::Session
  run RubyApp::Rack::Route.new
end
