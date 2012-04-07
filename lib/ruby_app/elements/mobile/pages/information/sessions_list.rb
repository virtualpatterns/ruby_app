module RubyApp

  module Elements

    module Mobile

      module Pages

        module Information
          require 'ruby_app/elements/mobile/pages/information/information_list'

          class SessionsList < RubyApp::Elements::Mobile::Pages::Information::InformationList

            template_path(:all, File.dirname(__FILE__))

            def initialize
              super
              self.items = RubyApp::Session.sessions.values
            end

          end

        end

      end

    end

  end

end
