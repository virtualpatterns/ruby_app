require 'rubygems'
require 'bundler/setup'

require 'mime/types'
require 'yajl'

module RubyApp

  module Rack
    require 'ruby_app/element'
    require 'ruby_app/elements/exception_element'
    require 'ruby_app/elements/pages/quit_page'
    require 'ruby_app/exceptions/session_invalid_exception'
    require 'ruby_app/log'
    require 'ruby_app/mixins/route_mixin'
    require 'ruby_app/request'
    require 'ruby_app/session'

    class Route
      extend RubyApp::Mixins::RouteMixin

      def call(environment)
        self.class.do_route(RubyApp::Request.request_method, RubyApp::Request.path)
      end

      route(RubyApp::Mixins::RouteMixin::GET, /\/quit/) do |method, path|
        begin
          [
            200,
            { 'content-type' => 'text/html' },
            [ RubyApp::Elements::Pages::QuitPage.new.render(:html) ]
          ]
        rescue Exception => exception
          RubyApp::Log.exception(exception)
          raise exception
        end
      end

      route(RubyApp::Mixins::RouteMixin::GET, /\/elements\/([^\.]+)\.([^\.\?]+)/) do |method, path, element_id, format|
        begin
          [
            200,
            { 'content-type' => RubyApp::Rack::Route.get_content_type(format) },
            [ RubyApp::Element.get_element(element_id).render(format.to_sym) ]
          ]
        rescue Exception => exception
          RubyApp::Log.exception(exception)
          [
            200,
            { 'content-type' => RubyApp::Rack::Route.get_content_type(format) },
            [ RubyApp::Elements::ExceptionElement.new(exception).render(format.to_sym) ]
          ]
        end
      end

      route(RubyApp::Mixins::RouteMixin::GET, /\.([^\.\?]+)/) do |method, path, format|
        begin
          [
            200,
            { 'content-type' => RubyApp::Rack::Route.get_content_type(format) },
            [
              RubyApp::Log.duration("#{self}.route method=#{method.inspect} path=#{path.inspect} format=#{format.to_sym.inspect} RubyApp::Session.pages.last=#{RubyApp::Session.pages.last.class}") do
                RubyApp::Session.pages.last.render(format.to_sym)
              end
            ]
          ]
        rescue Exception => exception
          RubyApp::Log.exception(exception)
          raise exception
        end
      end

      route(RubyApp::Mixins::RouteMixin::GET, /.*/) do |method, path|
        RubyApp::Log.debug("#{self}.route method=#{method.inspect} path=#{path.inspect}")
        do_route(RubyApp::Mixins::RouteMixin::GET, '/.html')
      end

      route(RubyApp::Mixins::RouteMixin::POST, /.*/) do |method, path|
        begin
          if RubyApp::Session.session_id == RubyApp::Request.POST['session_id']
            event = RubyApp::Element::Event.from_hash(RubyApp::Request.POST)
            event.process!
            [
              200,
              { 'content-type' => 'application/json' },
              [
                RubyApp::Log.duration("#{self}.route method=#{method.inspect} path=#{path.inspect} POST['_class']=#{RubyApp::Request.POST['_class']}") do
                  Yajl::Encoder.new.encode(event.to_hash)
                end
              ]
            ]
          else
            raise RubyApp::Exceptions::SessionInvalidException.new(RubyApp::Request.POST['session_id'])
          end
        rescue Exception => exception
          RubyApp::Log.exception(exception)
          [
            200,
            { 'content-type' => 'application/json' },
            [ Yajl::Encoder.new.encode(RubyApp::Element::ExceptionEvent.new(exception).to_hash) ]
          ]
        end
      end

      def self.get_content_type(format)
        ( mime_type = MIME::Types.type_for(format)[0] ) ? mime_type.content_type : 'text/plain'
      end

    end

  end

end
