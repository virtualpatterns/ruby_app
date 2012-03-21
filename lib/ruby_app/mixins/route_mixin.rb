require 'rubygems'
require 'bundler/setup'

require 'mime/types'

module RubyApp

  module Mixins

    module RouteMixin

      GET = 'GET'
      POST = 'POST'

      def route(method, pattern, &block)
        self.routes << { :method => method, :pattern => pattern, :block => block }
      end

      def do_route(method, path)
        self.routes.each do |route|
          if method == route[:method] and path =~ route[:pattern]
            return route[:block].call([method].concat($~.to_a))
          end
        end
      end

      def routes
        return @_routes ||= []
      end

    end

  end

end
