module RubyApp

  module Elements

    module Mobile

      module Dialogs

        module Calendars
          require 'ruby_app/elements/mobile/button'
          require 'ruby_app/elements/mobile/calendars/month'
          require 'ruby_app/elements/mobile/dialogs/response_dialog'

          class MonthDialog < RubyApp::Elements::Mobile::Dialogs::ResponseDialog

            template_path(:all, File.dirname(__FILE__))

            attr_accessor :value

            def initialize(today = Date.today, value = Date.today)
              super()

              @month = RubyApp::Elements::Mobile::Calendars::Month.new(today, value)
              @month.changed do |element, event|
                @response = @month.value
                self.hide(event, @today_link.options)
              end

              @previous_link = RubyApp::Elements::Mobile::Button.new
              @previous_link.attributes.merge!('data-icon'    => 'arrow-l',
                                               'data-iconpos' => 'left',
                                               'data-inline'  => true)
              @previous_link.clicked do |element, event|
                @month.move_previous(event)
                event.update_text('div[data-role="header"] h1', RubyApp::Language.locale.strftime(@month.display, '%b %Y'))
                event.update_text("##{@previous_link.element_id} span.ui-btn-text", RubyApp::Language.locale.strftime(@month.display << 1, '%b'))
                event.update_text("##{@next_link.element_id} span.ui-btn-text", RubyApp::Language.locale.strftime(@month.display >> 1, '%b'))
              end

              @today_link = RubyApp::Elements::Mobile::Dialogs::ResponseDialog::CloseLink.new
              @today_link.clicked do |element, event|
                @response = today
                self.hide(event, element.options)
              end

              @next_link = RubyApp::Elements::Mobile::Button.new
              @next_link.attributes.merge!('data-icon'    => 'arrow-r',
                                           'data-iconpos' => 'right',
                                           'data-inline'  => true)
              @next_link.clicked do |element, event|
                @month.move_next(event)
                event.update_text('div[data-role="header"] h1', RubyApp::Language.locale.strftime(@month.display, '%b %Y'))
                event.update_text("##{@previous_link.element_id} span.ui-btn-text", RubyApp::Language.locale.strftime(@month.display << 1, '%b'))
                event.update_text("##{@next_link.element_id} span.ui-btn-text", RubyApp::Language.locale.strftime(@month.display >> 1, '%b'))
              end

            end

          end

        end

      end

    end

  end

end
