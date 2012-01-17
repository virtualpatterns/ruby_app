module RubyApp

  module Mixins

    module TemplateMixin

      def template_name

        name = self.to_s.split('::').last
        name.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
        name.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
        name.tr!("-", "_")
        name.downcase

      end

      def template_path(format, path)
        (@_template_path ||= {})[format] = File.directory?(path) ? "#{File.join(path, self.template_name)}.*.haml" : path
      end

      def exclude_parent_template?(format)
        ( @_exclude_parent_template_formats ||= [] ).include?(:all) || @_exclude_parent_template_formats.include?(format)
      end

      def exclude_parent_template(*formats)
        @_exclude_parent_template_formats = formats
      end

      def get_template(format)
        (@_template_path[format] || @_template_path[:all]).gsub(/\*/,format.to_s)
      end

      def get_cache(format)
        template = self.get_template(format)
        File.join(File.dirname(template), '.cache', File.basename(template))
      end

      def get_templates(format)
        template = self.get_template(format)
        (File.exists?(template) ? [template] : []).concat((!self.exclude_parent_template?(format) && self.superclass.respond_to?(:get_templates) ) ? self.superclass.get_templates(format) : [])
      end

    end

  end

end
