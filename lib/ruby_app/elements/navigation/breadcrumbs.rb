module RubyApp

  module Elements

    module Navigation
      require 'ruby_app/elements/navigation/base/base_breadcrumbs'

      class Breadcrumbs < RubyApp::Elements::Navigation::Base::BaseBreadcrumbs

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super
        end

      end

    end

  end

end
