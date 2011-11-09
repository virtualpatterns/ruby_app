require 'rubygems'
require 'bundler/setup'

require 'ruby-event'

module RubyApp

  module Elements

    module Navigation

      module Base
        require 'ruby_app/element'

        class BaseBreadcrumbs < RubyApp::Element

          class ClickedEvent < RubyApp::Element::Event

            attr_reader :page

            def initialize(data)
              super(data)
              @page = RubyApp::Element.get_element(data['page_id'])
            end

            def to_hash
              super.merge('page_id' => @page.element_id)
            end

          end

          template_path(:all, File.dirname(__FILE__))

          def initialize
            super
          end

          protected

            def on_event(event)
              on_clicked(event) if event.is_a?(RubyApp::Elements::Navigation::Base::BaseBreadcrumbs::ClickedEvent)
              super(event)
            end

            def on_clicked(event)
              RubyApp::Session.pages.slice!(RubyApp::Session.pages.index(event.page) + 1, RubyApp::Session.pages.length - ( RubyApp::Session.pages.index(event.page) + 1 ))
              event.refresh
            end

        end

      end

    end

  end

end
