module RubyApp

  module Elements

    module Pages

      module TestPages
        require 'ruby_app/elements'

        class LinkedTestPage < RubyApp::Elements::Pages::BlankPage

          template_path(:all, File.dirname(__FILE__))

          def initialize
            super

            @markdown = RubyApp::Elements::Markdown.new

          end

        end

      end

    end

  end

end
