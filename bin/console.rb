require 'rubygems'
require 'bundler/setup'

require 'ruby_app'

puts "Running #{__FILE__.inspect}"

RubyApp::Configuration.load!([File.join(RubyApp::ROOT, %w[configuration.yml])])
RubyApp::Log.open!
RubyApp::Application.create!

at_exit do
  RubyApp::Application.destroy!
  RubyApp::Log.close!
  RubyApp::Configuration.unload!
end
