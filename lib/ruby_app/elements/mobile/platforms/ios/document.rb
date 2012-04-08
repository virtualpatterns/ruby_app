module RubyApp

  module Elements

    module Mobile

      module Platforms

        module Ios
          require 'ruby_app/elements/mobile/document'

          class Document < RubyApp::Elements::Mobile::Document

            template_path(:all, File.dirname(__FILE__))

            exclude_parent_template(:html)

            def initialize
              super
              self.attributes.merge!('manifest' => '/ruby_app/resources/elements/mobile/platforms/ios/manifest')
            end

          end

        end

      end

    end

  end

end
