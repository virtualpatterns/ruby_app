require 'rubygems'
require "bundler/gem_tasks"
require 'bundler/setup'

require 'rake'
require 'terminal-table'

require 'ruby_app'

namespace :ruby_app do

  desc 'Get version'
  task :version do |task|
    puts RubyApp::VERSION
  end

  desc 'Push to master, release, and increment version'
  task :release do |task|
      system('git push origin master && rake release')
      version_file = File.join(RubyApp::ROOT, %w[version.rb])
      RubyApp::VERSION =~ /(\d+)\.(\d+)\.(\d+)/
      system("sed 's|[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*|#{$1}.#{$2}.#{$3.to_i + 1}|g' < '#{version_file}' > '#{version_file}.out'; rm '#{version_file}'; mv '#{version_file}.out' '#{version_file}'")
      system("git commit --all --message=\'Version #{RubyApp::VERSION}\'")
  end

  namespace :process do

    desc 'Create console'
    task :console do |task|
      system('cd ./lib/ruby_app && clear && bundle exec ../../bin/ruby_app console')
    end

    desc 'Run'
    task :run => ['ruby_app:cache:destroy'] do |task|
      system('cd ./lib/ruby_app && clear && bundle exec ../../bin/ruby_app run')
    end

  end

  namespace :cache do

    desc 'List all cached files'
    task :list do
      system('find . | grep \'\\.cache\'')
    end

    desc 'Remove all cached files'
    task :destroy do
      puts 'Removing cached files ...'
      system('find . -name \'.cache\' | xargs rm -rv')
    end

  end

end
