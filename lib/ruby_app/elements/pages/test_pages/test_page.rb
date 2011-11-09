module RubyApp

  module Elements

    module Pages

      module TestPages
        require 'ruby_app/elements/markdown'
        require 'ruby_app/elements/pages/blank_page'

        class TestPage < RubyApp::Elements::Pages::BlankPage

          template_path(:all, File.dirname(__FILE__))

          def initialize
            super

            self.interval = 2

            @markdown = RubyApp::Elements::Markdown.new

            self.loaded do |element, event|
              event.update_text('li#loaded', self.translate.loaded)
            end
            self.triggered do |element, event|
              event.update_text('li#triggered', self.translate.triggered)
            end
            self.unloaded do |element, event|
              event.update_text('li#unloaded', self.translate.unloaded)
            end

          end

        end

      end

    end

  end

end
