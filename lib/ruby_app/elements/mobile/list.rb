require 'rubygems'
require 'bundler/setup'

require 'ruby-event'

module RubyApp

  module Elements

    module Mobile
      require 'ruby_app/element'

      class List < RubyApp::Element

        class ClickedEvent < RubyApp::Element::Event

          attr_reader :index, :item

          def initialize(data)
            super(data)
            @index = data['index'].to_i
            @item = self.source.items[@index]
          end

          def to_hash
            super.merge('index' => @index)
          end

        end

        template_path(:all, File.dirname(__FILE__))

        attr_accessor :items

        event :clicked

        def initialize
          super
          self.attributes.merge!('data-role' => 'listview')

          @items = []

        end

        protected

          def on_event(event)
            on_clicked(event) if event.is_a?(RubyApp::Elements::Mobile::List::ClickedEvent)
            super(event)
          end

          def on_clicked(event)
            clicked(event)
          end

      end

    end

  end

end
