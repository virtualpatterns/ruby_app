require 'rubygems'
require 'bundler/setup'

require 'fileutils'

module RubyApp
  require 'ruby_app/configuration'
  require 'ruby_app/log'
  require 'ruby_app/mixins/configuration_mixin'
  require 'ruby_app/mixins/delegate_mixin'
  require 'ruby_app/mixins/hash_mixin'
  require 'ruby_app/session'
  require 'ruby_app/version'

  class Application
    extend RubyApp::Mixins::DelegateMixin
    include RubyApp::Mixins::ConfigurationMixin

    attr_reader :options, :environment

    def initialize(options)
      @options = options
      @environment = {}
    end

    def self.get
      @@_application ||= nil
    end

    def self.create!(options = {})
      _options = { :application_class => RubyApp::Application,
                   :session_class => RubyApp::Session,
                   :log_path => File.join(RubyApp::ROOT, %w[process log application.log]),
                   :configuration_paths => [],
                   :default_language => :en,
                   :translations_paths => [] }.merge(options)
      _options[:configuration_paths] = [File.join(RubyApp::ROOT, %w[config.yml])] + ( _options[:configuration_paths].is_a?(Array) ? _options[:configuration_paths] : [_options[:configuration_paths]] )
      _options[:translations_paths] = [File.join(RubyApp::ROOT, %w[translations])] + ( _options[:translations_paths].is_a?(Array) ? _options[:translations_paths] : [_options[:translations_paths]] )
      RubyApp::Log.open!(_options[:log_path])
      RubyApp::Configuration.load!(_options[:configuration_paths])
      @@_application = _options[:application_class].new(_options)
    end

    def self.destroy!
      RubyApp::Configuration.unload!
      RubyApp::Log.close!
      @@_application = nil
    end

    def self.create_cache(path, root)
      RubyApp::Application.create!
      begin
        Dir.glob(File.join(path, %w[** *.rb])).each do |element_file|
          RubyApp::Request.create!
          begin
            require element_file
            element_class = element_file.gsub(root, '')
            element_class = element_class.gsub(/^\//, '')
            element_class = element_class.gsub(/\.rb$/, '')
            element_class = RubyApp::Application.upcode(element_class)
            begin
              element_class = eval(element_class)
              [:css, :js].each do |format|
                begin
                  element_class.render(format, true)
                rescue Exception => exception
                  puts "#{element_class}.render(#{format.inspect}) exception=#{exception.message}"
                end
              end
            rescue Exception => exception
              puts exception.message
            end
          ensure
            RubyApp::Request.destroy!
          end
        end
      ensure
        RubyApp::Application.destroy!
      end
    end

    def self.destroy_cache(path)
      Dir.glob(File.join(path, %w[** .cache])).each do |directory|
        FileUtils.rm_r(directory)
      end
    end

    def self.upcode(value)
      value = value.gsub(/\/(.?)/) { "::#{$1.upcase}" }
      value.gsub(/(?:^|_)(.)/) { $1.upcase }
    end

  end

end
