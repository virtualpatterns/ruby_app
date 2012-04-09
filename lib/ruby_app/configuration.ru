#\ --warn --port 8008 --pid ./rack.pid --debug true
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

map '/favicon.ico' do
  run Rack::File.new(File.join(RubyApp::ROOT, %w[resources favicon.ico]))
end

map '/' do
  use RubyApp::Rack::Request
  use RubyApp::Rack::Response
  use RubyApp::Rack::Language
  use RubyApp::Rack::Session
  run RubyApp::Rack::Route.new
end
