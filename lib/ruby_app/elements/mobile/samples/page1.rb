module RubyApp

  module Elements

    module Mobile

      module Samples
        require 'ruby_app/elements/mobile/page'

          class Page1 < RubyApp::Elements::Mobile::Page

            template_path(:all, File.dirname(__FILE__))

            def initialize
              super
            end

          end

        end

      end

  end

end
