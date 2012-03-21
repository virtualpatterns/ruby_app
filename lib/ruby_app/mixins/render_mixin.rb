require 'rubygems'
require 'bundler/setup'

require 'haml'

module RubyApp

  module Mixins

    module RenderMixin
      require 'ruby_app'

      def cache(format)
        self.is_a?(Class) ? self.get_cache(format) : self.class.get_cache(format)
      end

      def templates(format)
        self.is_a?(Class) ? self.get_templates(format) : self.class.get_templates(format)
      end

      def rendered?(file)
        unless RubyApp::Response.rendered?(file)
          yield
          RubyApp::Response.rendered(file)
        end
      end

      def content_for(name, value = nil, &block)
        RubyApp::Response.content_for(self, name, value, &block)
      end

      def render(format, write_cache = false)

        cache = self.cache(format)

        if File.exists?(cache)
          self.rendered?(cache) do
            return File.read(cache)
          end
        else

          templates = self.templates(format)

          unless templates.empty?

            self.init_haml_helpers unless @haml_buffer

            begin

              yield(self) if block_given?

              templates.each_with_index do |template, index|
                content = Haml::Engine.new(File.read(template), :filename => template).render(self) do |*arguments|
                  if arguments.empty?
                    index == 0 ? nil : RubyApp::Response.get_content(self, templates[index - 1])
                  else
                    _content = RubyApp::Response.get_content(self, arguments[0])
                    if self.block_is_haml?(_content)
                      self.capture_haml(arguments, &_content)
                    else
                      _content
                    end
                  end
                end
                RubyApp::Response.content_for(self, template, content)
              end

              if cache && write_cache
                cache_directory = File.dirname(cache)
                Dir.mkdir(cache_directory) unless File.exists?(cache_directory)
                File.open(cache, 'w') do |file|
                  file.write(RubyApp::Response.get_content(self, templates.last))
                  file.flush
                end
              end

              return RubyApp::Response.get_content(self, templates.last)

            ensure
              RubyApp::Response.clear_content(self)
            end

          end
        end
      end

    end

  end

end
