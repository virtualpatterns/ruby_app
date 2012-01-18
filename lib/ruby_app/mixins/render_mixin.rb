require 'rubygems'
require 'bundler/setup'

require 'haml'

module RubyApp

  module Mixins

    module RenderMixin
      require 'ruby_app/log'
      require 'ruby_app/request'

      def rendered?(template)
        unless RubyApp::Request.rendered?(template)
          yield
          RubyApp::Request.rendered(template)
        end
      end

      def content_for(name, value = nil, &block)
        RubyApp::Request.content_for(self, name, value, &block)
      end

      def render(format)
        cache = self.is_a?(Class) ? self.get_cache(format) : self.class.get_cache(format)
        if File.exists?(cache)
          self.rendered?(cache) do
            RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} File.read(#{cache.inspect})")
            File.read(cache)
          end
        end
        templates = self.is_a?(Class) ? self.get_templates(format) : self.class.get_templates(format)
        unless templates.empty?
          self.init_haml_helpers
          begin
            yield(self) if block_given?
            templates.each_with_index do |template, index|
              content = Haml::Engine.new(File.read(template), :filename => template).render(self) do |*arguments|
                if arguments.empty?
                  index == 0 ? nil : RubyApp::Request.get_content(self, templates[index - 1])
                else
                  _content = RubyApp::Request.get_content(self, arguments[0])
                  if self.block_is_haml?(_content)
                    self.capture_haml(arguments, &_content)
                  else
                    _content
                  end
                end
              end
              RubyApp::Request.content_for(self, template, content)
            end
            if cache && RubyApp::Request.cache?
              RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} File.open(#{cache.inspect}, 'w')")
              cache_directory = File.dirname(cache)
              Dir.mkdir(cache_directory) unless File.exists?(cache_directory)
              File.open(cache, 'w') do |file|
                file.write(RubyApp::Request.get_content(self, templates.last))
                file.flush
              end
            end
            return RubyApp::Request.get_content(self, templates.last)
          ensure
            RubyApp::Request.clear_content(self)
          end
        end

      end

    end

  end

end
