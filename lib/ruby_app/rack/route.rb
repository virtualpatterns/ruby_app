require 'rubygems'
require 'bundler/setup'

require 'yajl'

module RubyApp

  module Rack
    require 'ruby_app'
    require 'ruby_app/elements'
    require 'ruby_app/mixins'

    class Route
      extend RubyApp::Mixins::RouteMixin

      def call(environment)
        RubyApp::Rack::Route.do_route(RubyApp::Request.request_method, RubyApp::Request.path)
      end

      route(RubyApp::Mixins::RouteMixin::GET, /\/quit/) do |method, path|
        RubyApp::Log.debug("#{RubyApp::Session.session_id} GET  /quit")
        RubyApp::Session.quit!
        RubyApp::Response['Content-Type'] = 'text/html'
        RubyApp::Response.write(RubyApp::Elements::Pages::QuitPage.new.render(:html))
      end

      route(RubyApp::Mixins::RouteMixin::GET, /\/elements\/([^\.]+)\.([^\.\?]+)/) do |method, path, element_id, format|
        RubyApp::Response['Content-Type'] = RubyApp::Element.get_content_type(format)
        begin
          element = RubyApp::Element.get_element(element_id)
          RubyApp::Log.duration("#{RubyApp::Session.session_id} GET  #{element.class} #{format}") do
            RubyApp::Response.write(element.render(format.to_sym))
          end
        rescue Exception => exception
          RubyApp::Response.write(RubyApp::Elements::ExceptionElement.new(exception).render(format.to_sym))
        end
      end

      route(RubyApp::Mixins::RouteMixin::GET, /\.([^\.\?]+)/) do |method, path, format|
        RubyApp::Response['Content-Type'] = RubyApp::Element.get_content_type(format)
        page = RubyApp::Session.pages.last
        RubyApp::Log.duration("#{RubyApp::Session.session_id} GET  #{page.class} #{format}") do
          RubyApp::Response.write(page.render(format.to_sym))
        end
      end

      route(RubyApp::Mixins::RouteMixin::GET, /.*/) do |method, path|
        RubyApp::Rack::Route.do_route(RubyApp::Mixins::RouteMixin::GET, '/.html')
      end

      route(RubyApp::Mixins::RouteMixin::POST, /.*/) do |method, path|
        RubyApp::Response['Content-Type'] = 'application/json'
        begin
          event = RubyApp::Element::Event.from_hash(RubyApp::Request.POST)
          RubyApp::Log.duration("#{RubyApp::Session.session_id} POST #{event.class}") do
            event.process!
            RubyApp::Response.write(Yajl::Encoder.new.encode(event.to_hash))
          end
        rescue Exception => exception
          RubyApp::Response.write(Yajl::Encoder.new.encode(RubyApp::Element::ExceptionEvent.new(exception).to_hash))
        end
      end

    end

  end

end
