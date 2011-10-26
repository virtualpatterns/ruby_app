# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ruby_app/version"

Gem::Specification.new do |s|
  s.name        = "RubyApp"
  s.version     = RubyApp::VERSION
  s.authors     = ["Frank G. Ficnar"]
  s.email       = ["frank.ficnar@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{A web application framework in Ruby}
  s.description = %q{A web application framework in Ruby}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'BlueCloth',                   '1.0.1'
  s.add_dependency 'chronic_duration',            '0.9.6'
  s.add_dependency 'facets',                      '2.9.2'
  s.add_dependency 'fileutils',                   '0.7'
  s.add_dependency 'haml',                        '3.1.2'
  s.add_dependency 'json',                        '1.6.1'
  s.add_dependency 'mime-types',                  '1.16'
  s.add_dependency 'r18n-core',                   '0.4.9'
  s.add_dependency 'rack',                        '1.2.2'
  s.add_dependency 'ruby-event',                  '1.0.0'
  s.add_dependency 'ruby-openid',                 '2.1.8'
  s.add_dependency 'sass',                        '3.1.7'
  s.add_dependency 'term-ansicolor',              '1.0.6'
  s.add_dependency 'yajl-ruby',                   '0.8.2'

  s.add_development_dependency 'capybara',        '1.0.0'
  s.add_development_dependency 'cucumber',        '1.0.0'
  s.add_development_dependency 'launchy',         '0.3.7'
  s.add_development_dependency 'rspec',           '2.6.0'
  s.add_development_dependency 'rspec-mocks',     '2.6.0'
  s.add_development_dependency 'ya2yaml',         '0.30'
end
