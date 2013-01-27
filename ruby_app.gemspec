# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ruby_app/version"

Gem::Specification.new do |s|
  s.name        = "RubyApp"
  s.version     = RubyApp::VERSION
  s.authors     = ["Frank G. Ficnar"]
  s.email       = ["frank.ficnar@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{A mobile web application framework in Ruby}
  s.description = %q{A mobile web application framework in Ruby}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'bluecloth'
  s.add_dependency 'chronic'
  s.add_dependency 'chronic_duration'
  s.add_dependency 'facets'
  s.add_dependency 'fileutils'
  s.add_dependency 'haml'
  s.add_dependency 'json'
  s.add_dependency 'koala'
  s.add_dependency 'mime-types'
  s.add_dependency 'oauth2'
  s.add_dependency 'r18n-core'
  s.add_dependency 'rack'
  s.add_dependency 'ruby-event'
  s.add_dependency 'ruby-openid'
  s.add_dependency 'sass'
  s.add_dependency 'system_timer'
  s.add_dependency 'term-ansicolor'
  s.add_dependency 'terminal-table'
  s.add_dependency 'yajl-ruby'

  s.add_development_dependency 'rake'
end
