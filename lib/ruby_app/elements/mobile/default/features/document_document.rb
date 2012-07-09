module RubyApp

  module Elements

    module Mobile

      module Default

        module Features
          require 'ruby_app'
          require 'ruby_app/elements/mobile/document'

          class DocumentDocument < RubyApp::Elements::Mobile::Document

            template_path(:all, File.dirname(__FILE__))

          end

        end

      end

    end

  end

end
