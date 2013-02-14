require 'rubygems'
require 'bundler/setup'

require 'ruby_app'

# Placeholder for template application LOAD_PATH.unshift ...

# Placeholder for template application require

puts "Running #{__FILE__.inspect}"

RubyApp::Configuration.load!([File.join(RubyApp::ROOT, %w[configuration.yml])])
# Placeholder for template application configuration
RubyApp::Log.open!
RubyApp::Application.create!

at_exit do
  RubyApp::Application.destroy!
  RubyApp::Log.close!
  RubyApp::Configuration.unload!
end
