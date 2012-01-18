require 'rubygems'
require 'bundler/setup'

require 'haml'

module RubyApp

  module Mixins

    module RenderMixin
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
            return RubyApp::Request.get_content(self, templates.last)
          ensure
            RubyApp::Request.clear_content(self)
          end
        end

      end

    end

  end

end
