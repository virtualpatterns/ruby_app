require 'rubygems'
require 'bundler/setup'

require 'haml'

module RubyApp

  module Mixins

    module RenderMixin
      require 'ruby_app'

      def get_templates(format)
        return self.is_a?(Class) ? super(format) : self.class.get_templates(format)
      end

      def get_default_template
        return self.is_a?(Class) ? super : self.class.get_default_template
      end

      def get_cache(format)
        return self.is_a?(Class) ? super(format) : self.class.get_cache(format)
      end

      def content_for(format, name, value = nil, &block)
        return RubyApp::Response.content_for(self, format, name, value, &block)
      end

      def render(format)

        templates = self.get_templates(format)

        #RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} format=#{format.inspect}")
        #templates.each_with_index do |template, index|
        #  RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} templates[#{index.inspect}]=#{template.inspect}")
        #end

        unless templates.empty?

          self.init_haml_helpers unless @haml_buffer

          yield(self) if block_given?

          templates.each_with_index do |template, index|
            #RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} template=#{template.inspect}")

            if RubyApp::Response.rendered?(self, template)
              template = self.get_default_template
              templates[index] = template
            end

            #RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} template=#{template.inspect}")

            content = Haml::Engine.new(File.read(template), :filename => template).render(self) do |*arguments|
              if arguments.empty?
                #RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} index=#{index.inspect} templates[#{index - 1}]=#{templates[index - 1].inspect}") unless index == 0
                index == 0 ? nil : RubyApp::Response.get_content(self, format, templates[index - 1])
              else
                _content = RubyApp::Response.get_content(self, format, arguments[0])
                if self.block_is_haml?(_content)
                  self.capture_haml(arguments, &_content)
                else
                  _content
                end
              end
            end

            RubyApp::Response.rendered(self, template)
            RubyApp::Response.content_for(self, format, template, content)

          end

          return RubyApp::Response.get_content(self, format, templates.last)

        end
      end

    end

  end

end
