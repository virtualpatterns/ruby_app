module RubyApp

  module Elements

    module Mobile

      module Platforms

        module Ios
          require 'ruby_app/elements/mobile/document'

          class Document < RubyApp::Elements::Mobile::Document

            template_path(:all, File.dirname(__FILE__))

            def initialize
              super
              self.attributes.merge!('manifest' => '/ruby_app/resources/elements/mobile/platforms/ios/manifest')

              self.metadata.merge!('apple-mobile-web-app-capable'          => 'yes',
                                   'apple-mobile-web-app-status-bar-style' => 'black')
              self.links.merge!('apple-touch-icon'          => '/ruby_app/resources/elements/mobile/platforms/ios/apple-touch-icon.png',
                                'apple-touch-startup-image' => '/ruby_app/resources/elements/mobile/platforms/ios/apple-touch-startup-image.png')

            end

          end

        end

      end

    end

  end

end
