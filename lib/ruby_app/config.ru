#\ --warn --port 8008 --pid ./rack.pid --debug true
require 'rubygems'
require 'bundler/setup'

require 'rack'

require 'ruby_app/rack/application'
require 'ruby_app/rack/route'
require 'ruby_app/version'

use Rack::ShowExceptions
use Rack::Session::Pool
use Rack::Reloader
use Rack::ContentLength

use RubyApp::Rack::Application
run RubyApp::Rack::Route.new

map '/favicon.ico' do
  run Rack::File.new(File.join(RubyApp::ROOT, %w[resources favicon.ico]))
end

map '/ruby_app/resources' do
  run Rack::File.new(File.join(RubyApp::ROOT, %w[resources]))
end
