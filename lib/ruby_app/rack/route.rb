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
        RubyApp::Log.debug("ROUTE     #{RubyApp::Request.request_method} #{RubyApp::Request.path.gsub(/^#{RubyApp::root}/,'')}")
        RubyApp::Rack::Route.do_route(RubyApp::Request.request_method, RubyApp::Request.path.gsub(/^#{RubyApp::root}/,''))
      end

      route(RubyApp::Mixins::RouteMixin::GET, /\/quit/) do |method, path|
        begin
          RubyApp::Log.duration(RubyApp::Log::INFO, "GET       /quit") do
            RubyApp::Session.quit!
            unless RubyApp::Request.query['go']
              RubyApp::Response['Content-Type'] = 'text/html'
              RubyApp::Response.write(RubyApp::Elements::Mobile::Documents::QuitDocument.new.render(:html))
            else
              RubyApp::Response.redirect(RubyApp::Request.query['go'])
            end
          end
        rescue => exception
          RubyApp::Log.exception(RubyApp::Log::ERROR, exception)
          raise
        end
      end

      route(RubyApp::Mixins::RouteMixin::GET, /\/elements\/([^\.]+)\.([^\.\?]+)/) do |method, path, element_id, format|
        #RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} --> #{method} #{path} #{element_id} #{format}")
        begin
          element = RubyApp::Element.get_element(element_id)
          RubyApp::Log.duration(RubyApp::Log::INFO, "GET       #{element.class} #{format}") do
            RubyApp::Response['Content-Type'] = RubyApp::Response.get_content_type(format)
            RubyApp::Response.write_from_cache(element, format.to_sym)
          end
        rescue => exception
          RubyApp::Log.exception(RubyApp::Log::ERROR, exception)
          raise
        end
        #RubyApp::Log.debug("#{RubyApp::Log.prefix(self, __method__)} <-- #{method} #{path} #{element_id} #{format}")
      end

      route(RubyApp::Mixins::RouteMixin::GET, /\.([^\.\?]+)/) do |method, path, format|
        begin
          document = RubyApp::Session.document
          RubyApp::Log.duration(RubyApp::Log::INFO, "GET       #{document.class} #{format}") do
            RubyApp::Response['Content-Type'] = RubyApp::Response.get_content_type(format)
            RubyApp::Response.write_from_cache(document, format.to_sym)
          end
        rescue => exception
          RubyApp::Log.exception(RubyApp::Log::ERROR, exception)
          raise
        end
      end

      route(RubyApp::Mixins::RouteMixin::GET, /.*/) do |method, path|
        RubyApp::Rack::Route.do_route(RubyApp::Mixins::RouteMixin::GET, "/.html")
      end

      route(RubyApp::Mixins::RouteMixin::POST, /.*/) do |method, path|
        begin
          #RubyApp::Request.POST.each do |name, value|
          #  RubyApp::Log.debug("POST      #{name.to_sym.inspect}=#{value.inspect}")
          #end
          event = RubyApp::Element::Event.from_hash(RubyApp::Request.POST)
          RubyApp::Log.duration(RubyApp::Log::INFO, "EVENT     #{event.class}") do
            RubyApp::Session.process_event!(event)
            RubyApp::Response['Content-Type'] = 'application/json'
            RubyApp::Response.write(Yajl::Encoder.new.encode(event.to_hash))
          end
        rescue => exception
          RubyApp::Log.exception(RubyApp::Log::ERROR, exception)
          RubyApp::Response['Content-Type'] = 'application/json'
          RubyApp::Response.write(Yajl::Encoder.new.encode(RubyApp::Element::ExceptionEvent.new(exception).to_hash))
        end
      end

    end

  end

end
