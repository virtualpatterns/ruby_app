require 'rubygems'
require 'bundler/setup'

require 'ruby_app/application'

puts "Running #{__FILE__.inspect}"

RubyApp::Application.create
