module RubyApp

  module Elements

    module Mobile

      module Pages

        module Information
          require 'ruby_app/elements/mobile/pages/information/information_list'

          class SessionsList < RubyApp::Elements::Mobile::Pages::Information::InformationList

            class SessionsListItem < RubyApp::Elements::Mobile::List::ListItem

              template_path(:all, File.dirname(__FILE__))

              alias :session :item

              def initialize(session)
                super(session)
              end

            end

            template_path(:all, File.dirname(__FILE__))

            def initialize
              super
              self.items = RubyApp::Session.sessions.values.collect { |session| RubyApp::Elements::Mobile::Pages::Information::SessionsList::SessionsListItem.new(session) }
            end

          end

        end

      end

    end

  end

end
