module RubyApp

  module Elements

    module Mobile

      module Documents
        require 'ruby_app/elements/mobile/document'

        class MailDocument < RubyApp::Elements::Mobile::Document

          template_path(:all, File.dirname(__FILE__))

          exclude_parent_template(:all)

          def initialize
            super
          end

          def render(format)
            RubyApp::Request.create_context! do
              return super(format)
            end
          end

        end

      end

    end

  end

end
