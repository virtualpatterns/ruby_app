module RubyApp

  module Elements

    module Mobile

      module Documents
        require 'ruby_app/elements/mobile/document'

        class MailDocument < RubyApp::Elements::Mobile::Document

          template_path(:all, File.dirname(__FILE__))

          def initialize
            super
          end

        end

      end

    end

  end

end
