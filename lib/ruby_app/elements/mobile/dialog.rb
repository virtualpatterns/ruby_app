module RubyApp

  module Elements

    module Mobile
      require 'ruby_app/elements/mobile/page'

      class Dialog < RubyApp::Elements::Mobile::Page

        template_path(:all, File.dirname(__FILE__))

        exclude_parent_template(:html, :js)

        def initialize
          super
          self.attributes.merge!('data-role' => 'dialog')
        end

        def self.show(event, dialog, options = {})
          dialog.show(event, options)
          if block_given?
            dialog.removed do |element, _event|
              yield _event, dialog.response
            end
          end
        end

      end

    end

  end

end
