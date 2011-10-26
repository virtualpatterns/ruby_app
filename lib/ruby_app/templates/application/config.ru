#\ --warn --port 8008 --pid ./rack.pid

$ROOT = File.expand_path(File.join(File.dirname(__FILE__), %w[.]))
$LOAD_PATH.unshift $ROOT unless $LOAD_PATH.include?($ROOT)

require 'rubygems'
require 'bundler/setup'

require 'rack'

require 'ruby_app/rack/application'
require 'ruby_app/rack/route'
require 'ruby_app/version'

require 'application'
require 'session'
require 'version'

use Rack::ShowExceptions
use Rack::Session::Pool
use Rack::Reloader
use Rack::ContentLength

map '/favicon.ico' do
  run Rack::File.new(File.join(RubyApp::ROOT, %w[resources favicon.ico]))
end

map '/ruby_app/resources' do
  run Rack::File.new(File.join(RubyApp::ROOT, %w[resources]))
end

map '/_APPLICATION_DOWNCODE_/resources' do
  run Rack::File.new(File.join(_APPLICATION_UPCODE_::ROOT, %w[resources]))
end

map '/' do
  use RubyApp::Rack::Application, :application_class => _APPLICATION_UPCODE_::Application,
                                  :session_class => _APPLICATION_UPCODE_::Session,
                                  :log_path => File.join(_APPLICATION_UPCODE_::ROOT, %w[log application.log]),
                                  :configuration_paths => File.join(_APPLICATION_UPCODE_::ROOT, %w[config.yml]),
                                  :default_language => :en,
                                  :translations_paths => File.join(_APPLICATION_UPCODE_::ROOT, %w[translations])
  run RubyApp::Rack::Route.new
end
