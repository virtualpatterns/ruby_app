require 'rubygems'
require 'bundler/setup'

require 'fileutils'

module RubyApp
  require 'ruby_app/mixins'

  class Application
    extend RubyApp::Mixins::ConfigurationMixin
    extend RubyApp::Mixins::DelegateMixin

    attr_reader :options, :environment

    def initialize
      @environment = {}
    end

    def self.get
      @@_application ||= nil
    end

    def self.create!
      @@_application = ( Kernel.eval(RubyApp::Application.configuration._class) ).new
    end

    def self.destroy!
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
