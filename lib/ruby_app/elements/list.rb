require 'rubygems'
require 'bundler/setup'

require 'ruby-event'

module RubyApp

  module Elements
    require 'ruby_app/element'

    class List < RubyApp::Element

      class SelectedEvent < RubyApp::Element::Event

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

      event :selected

      def initialize
        super
        @items = []
      end

      protected

        def on_event(event)
          on_selected(event) if event.is_a?(RubyApp::Elements::List::SelectedEvent)
          super(event)
        end

        def on_selected(event)
          selected(event)
        end

    end

  end

end
