module RubyApp
  
  module Mixins
    
    module Template
      
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
      
      def get_templates(format)
        templates = Dir.glob((@_template_path[format] || @_template_path[:all] || "#{File.join(File.dirname(__FILE__), self.template_name)}.*.haml").gsub(/\*/,format.to_s))
        ( templates.length > 0 ? [templates.first] : [] ).concat( ( !self.exclude_parent_template?(format) and self.superclass.respond_to?(:get_templates) ) ? self.superclass.get_templates(format) : [] )
      end
      
    end
    
  end
  
end
