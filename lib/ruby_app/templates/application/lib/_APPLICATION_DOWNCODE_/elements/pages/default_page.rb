require 'rubygems'
require 'bundler/setup'

require 'ruby_app/elements'

module _APPLICATION_UPCODE_

  module Elements

    module Pages

      class DefaultPage < RubyApp::Elements::Mobile::Page

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super

          @information_link = RubyApp::Elements::Mobile::Navigation::NavigationLink.new
          @information_link.attributes.merge!('class' => 'ui-btn-right',
                                              'data-icon' => 'info')
          @information_link.clicked do |element, event|
            RubyApp::Elements::Mobile::Pages::InformationPage.new(event.now).show(event, element.options)
          end

        end

      end

    end

  end

end
