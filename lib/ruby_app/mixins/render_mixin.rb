require 'rubygems'
require 'bundler/setup'

require 'facets/string/interpolate'
require 'haml'

module RubyApp

  module Mixins

    module RenderMixin
      require 'ruby_app/log'

      def rendered?(template)
        unless ( Thread.current[:_rendered] ||= {} ).key?(template)
          yield
          Thread.current[:_rendered][template] = ( Thread.current[:_rendered][template] || 0 ) + 1
        end
      end

      def content_for(name, value = nil, &block)
        ( @_content ||= {} )[Thread.current] ||= {}
        if block_given?
          @_content[Thread.current][name] = block
        elsif value
          @_content[Thread.current][name] = String.interpolate { value }
        else
          @_content[Thread.current][name]
        end
      end

      def clear_content_for
        ( @_content ||= {} )[Thread.current] ||= {}
        @_content.delete(Thread.current)
      end

      def render(format)

        self.init_haml_helpers

        begin

          yield(self) if block_given?

          templates = self.is_a?(Class) ? self.get_templates(format) : self.class.get_templates(format)
          templates.each_with_index do |template, index|
            #RubyApp::Log.debug("#{self.is_a?(Class) ? self : self.class}##{__method__} template=#{File.expand_path(template)}")
            content = Haml::Engine.new(File.read(template), :filename => template).render(self) do |*arguments|
              if arguments.empty?
                index == 0 ? nil : self.content_for(templates[index - 1])
              else
                _content = self.content_for(arguments[0])
                if self.block_is_haml?(_content)
                  self.capture_haml(arguments, &_content)
                else
                  _content
                end
              end
            end
            self.content_for(template, content)
          end

          self.content_for(templates.last)

        ensure
          self.clear_content_for
        end

      end

    end

  end

end
