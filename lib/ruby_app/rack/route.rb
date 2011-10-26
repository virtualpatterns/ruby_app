require 'rubygems'
require 'bundler/setup'

require 'mime/types'
require 'yajl'

module RubyApp

  module Rack
    require 'ruby_app/element'
    require 'ruby_app/elements/exception_element'
    require 'ruby_app/elements/pages/exception_page'
    require 'ruby_app/elements/pages/quit_page'
    require 'ruby_app/log'
    require 'ruby_app/mixins/route'
    require 'ruby_app/request'

    class Route
      extend RubyApp::Mixins::Route

      def call(environment)
        self.class.do_route(RubyApp::Request.request_method, RubyApp::Request.path)
      end

      route(RubyApp::Mixins::Route::GET, /\/quit/) do |method, path|
        RubyApp::Log.debug("#{self}.route method=#{method.inspect} path=#{path.inspect}")
        begin
          [
            200,
            { 'content-type' => 'text/html' },
            [ RubyApp::Elements::Pages::QuitPage.new.render(:html) ]
          ]
        rescue Exception => exception
          RubyApp::Log.error('-' * 80)
          RubyApp::Log.error("exception=#{exception.class.inspect} #{exception.message}")
          RubyApp::Log.error('-' * 80)
          RubyApp::Log.error(exception.backtrace.join("\n"))
          RubyApp::Log.error('-' * 80)
          [
            200,
            { 'content-type' => 'text/html' },
            [ RubyApp::Elements::Pages::ExceptionPage.new(exception).render(:html) ]
          ]
        end
      end

      route(RubyApp::Mixins::Route::GET, /\/elements\/([^\.]+)\.([^\.\?]+)/) do |method, path, element_id, format|
        RubyApp::Log.debug("#{self}.route method=#{method.inspect} path=#{path.inspect} element_id=#{element_id.inspect} format=#{format.to_sym.inspect}")
        begin
          [
            200,
            { 'content-type' => RubyApp::Rack::Route.get_content_type(format) },
            [ RubyApp::Element.get_element(element_id).render(format.to_sym) ]
          ]
        rescue Exception => exception
          RubyApp::Log.error('-' * 80)
          RubyApp::Log.error("exception=#{exception.class.inspect} #{exception.message}")
          RubyApp::Log.error('-' * 80)
          RubyApp::Log.error(exception.backtrace.join("\n"))
          RubyApp::Log.error('-' * 80)
          [
            200,
            { 'content-type' => RubyApp::Rack::Route.get_content_type(format) },
            [ RubyApp::Elements::ExceptionElement.new(exception).render(format.to_sym) ]
          ]
        end
      end

      route(RubyApp::Mixins::Route::GET, /\.([^\.\?]+)/) do |method, path, format|
        RubyApp::Log.debug("#{self}.route method=#{method.inspect} path=#{path.inspect} format=#{format.to_sym.inspect}")
        begin
          [
            200,
            { 'content-type' => RubyApp::Rack::Route.get_content_type(format) },
            [ RubyApp::Session.pages.last.render(format.to_sym) ]
          ]
        rescue Exception => exception
          RubyApp::Log.error('-' * 80)
          RubyApp::Log.error("exception=#{exception.class.inspect} #{exception.message}")
          RubyApp::Log.error('-' * 80)
          RubyApp::Log.error(exception.backtrace.join("\n"))
          RubyApp::Log.error('-' * 80)
          [
            200,
            { 'content-type' => RubyApp::Rack::Route.get_content_type(format) },
            [ RubyApp::Elements::Pages::ExceptionPage.new(exception).render(format.to_sym) ]
          ]
        end
      end

      route(RubyApp::Mixins::Route::GET, /.*/) do |method, path|
        RubyApp::Log.debug("#{self}.route method=#{method.inspect} path=#{path.inspect}")
        do_route(RubyApp::Mixins::Route::GET, '/.html')
      end

      route(RubyApp::Mixins::Route::POST, /.*/) do |method, path|
        RubyApp::Log.debug("#{self}.post(...) method=#{method.inspect} path=#{path.inspect} POST=#{RubyApp::Request.POST.inspect}")
        begin
          event = RubyApp::Element::Event.from_hash(RubyApp::Request.POST)
          RubyApp::Session.process(event)
          [
            200,
            { 'content-type' => 'application/json' },
            [ Yajl::Encoder.new.encode(event.to_hash) ]
          ]
        rescue Exception => exception
          RubyApp::Log.error('-' * 80)
          RubyApp::Log.error("exception=#{exception.class.inspect} #{exception.message}")
          RubyApp::Log.error('-' * 80)
          RubyApp::Log.error(exception.backtrace.join("\n"))
          RubyApp::Log.error('-' * 80)
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
