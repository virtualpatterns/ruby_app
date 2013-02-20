module RubyApp

  module Elements

    module Mobile

      module Default

        module Features
          require 'ruby_app/elements/mobile/navigation/back_button'
          require 'ruby_app/elements/mobile/page'

          class TriggerPage < RubyApp::Elements::Mobile::Page

            template_path(:all, File.dirname(__FILE__))

            def initialize
              super

              @back_button = RubyApp::Elements::Mobile::Navigation::BackButton.new

              self.shown do |element, event|
                event.create_trigger(self, 1)
              end
              self.hidden do |element, event|
                event.destroy_trigger(self)
              end

              self.triggered do |element, event|
                event.update_text('div.message', "Triggered at #{RubyApp::Language.locale.strftime(Time.now, RubyApp::Application.configuration.format.date.long)}")
                event.destroy_trigger(self)
              end

            end

          end

        end

      end

    end

  end

end
