module RubyApp

  module Elements

    module Mobile

      module Default

        module Features

          module Calendars
            require 'ruby_app'
            require 'ruby_app/elements/mobile/default/features/calendars/month_page'
            require 'ruby_app/elements/mobile/navigation/back_button'
            require 'ruby_app/elements/mobile/navigation/page_button'
            require 'ruby_app/elements/mobile/page'

            class DefaultPage < RubyApp::Elements::Mobile::Page

              template_path(:all, File.dirname(__FILE__))

              def initialize
                super

                @back_button = RubyApp::Elements::Mobile::Navigation::BackButton.new

                @month_link = RubyApp::Elements::Mobile::Navigation::PageButton.new
                @month_link.page = RubyApp::Elements::Mobile::Default::Features::Calendars::MonthPage

              end

            end

          end

        end

      end

    end

  end

end
