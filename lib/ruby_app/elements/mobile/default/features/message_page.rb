module RubyApp

  module Elements

    module Mobile

      module Default

        module Features
          require 'ruby_app/elements/mobile/navigation/back_button'
          require 'ruby_app/elements/mobile/page'

          class MessagePage < RubyApp::Elements::Mobile::Page

            template_path(:all, File.dirname(__FILE__))

            def initialize
              super

              @back_button = RubyApp::Elements::Mobile::Navigation::BackButton.new

              self.shown do |element, event|
                event.send_message(self, "Message")
              end

              self.messaged do |element, event|
                event.update_text('div.message', "Messaged at #{RubyApp::Language.locale.strftime(Time.now, RubyApp::Application.configuration.format.date.long)} with message #{event.message ? event.message.inspect : '(none)'}")
              end

            end

          end

        end

      end

    end

  end

end
