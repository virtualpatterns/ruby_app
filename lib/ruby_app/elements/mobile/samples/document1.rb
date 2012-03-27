module RubyApp

  module Elements

    module Mobile

      module Samples
        require 'ruby_app/elements/mobile/document'

          class Document1 < RubyApp::Elements::Mobile::Document

            template_path(:all, File.dirname(__FILE__))

            def initialize
              super

              require 'ruby_app/elements/mobile/samples/page1'
              @page1 = RubyApp::Elements::Mobile::Samples::Page1.new

              require 'ruby_app/elements/mobile/samples/page2'
              @page2 = RubyApp::Elements::Mobile::Samples::Page2.new

            end

          end

        end

      end

  end

end
