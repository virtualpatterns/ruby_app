$ROOT = File.expand_path(File.join(File.dirname(__FILE__), %w[.]))
$LOAD_PATH.unshift $ROOT unless $LOAD_PATH.include?($ROOT)

require 'application'
require 'session'

puts "Running #{__FILE__.inspect}"

options = { :application_class => _APPLICATION_UPCODE_::Application,
            :session_class => _APPLICATION_UPCODE_::Session,
            :log_path => File.join(_APPLICATION_UPCODE_::ROOT, %w[log application.log]),
            :configuration_paths => File.join(_APPLICATION_UPCODE_::ROOT, %w[config.yml]),
            :default_language => :en,
            :translations_paths => File.join(_APPLICATION_UPCODE_::ROOT, %w[translations]) }

_APPLICATION_UPCODE_::Application.create options
