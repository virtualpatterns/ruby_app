#\ --port 8008 --pid ./rack.pid
$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), %w[lib]))

require 'rubygems'
require 'bundler/setup'

require 'rack'

require 'ruby_app'
require 'ruby_app/rack'

require '_APPLICATION_DOWNCODE_'

use Rack::ShowExceptions
use Rack::Reloader

#use RubyApp::Rack::Duration
#use RubyApp::Rack::Memory

use RubyApp::Rack::Application, :configuration_paths  => [ File.join(RubyApp::ROOT, %w[configuration.yml]),
                                                           File.join(_APPLICATION_UPCODE_::ROOT, %w[configuration.yml])]

map '/ruby_app/resources' do
  run Rack::File.new(File.join(RubyApp::ROOT, %w[resources]))
end

map '/_APPLICATION_DOWNCODE_/resources' do
  run Rack::File.new(File.join(_APPLICATION_UPCODE_::ROOT, %w[resources]))
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
