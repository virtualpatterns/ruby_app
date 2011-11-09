module RubyApp

  module Elements

    module Navigation
      require 'ruby_app/element'

      class PageMenu < RubyApp::Element

        class ClickedEvent < RubyApp::Element::Event

          attr_reader :page

          def initialize(data)
            super(data)
            @page = eval(data['page'])
          end

          def to_hash
            super.merge('page' => @page)
          end

        end

        template_path(:all, File.dirname(__FILE__))

        attr_reader :pages

        def initialize
          super
          @pages = []
        end

        def current_page
          RubyApp::Session.pages.last.class
        end

        protected

          def on_event(event)
            on_clicked(event) if event.is_a?(RubyApp::Elements::Navigation::PageMenu::ClickedEvent)
            super(event)
          end

          def on_clicked(event)
            RubyApp::Session.pages.pop
            RubyApp::Session.pages.push(event.page.new)
            event.refresh
          end

      end

    end

  end

end
