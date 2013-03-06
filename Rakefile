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

  desc 'Display commit difference between current branch and staging'
  task :changes do |task|
    system("git checkout development; git pull origin development; git log --pretty=format:'%H %s' production..HEAD")
  end

  desc 'Push to development'
  task :push do |task|
      system('git checkout development; git pull origin development; git push origin development')
  end

  desc 'Push to production, release, and increment version'
  task :release do |task|
      system('git checkout production; git pull origin production; git merge origin/development; git push origin production; rake release; git checkout development')
      version_file = File.join(RubyApp::ROOT, %w[version.rb])
      RubyApp::VERSION =~ /(\d+)\.(\d+)\.(\d+)/
      system("sed 's|[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*|#{$1}.#{$2}.#{$3.to_i + 1}|g' < '#{version_file}' > '#{version_file}.out'; rm '#{version_file}'; mv '#{version_file}.out' '#{version_file}'")
      system("git commit --all --message=\'Version #{$1}.#{$2}.#{$3.to_i + 1}\'")
  end

  namespace :process do

    desc 'Create console'
    task :console do |task|
      system('cd ./lib/ruby_app; bundle exec irb -r ./console.rb --back-trace-limit 100')
    end

    namespace :server do

      desc 'Start the server'
      task :start, [:daemonize] => ['ruby_app:cache:destroy'] do |task, arguments|
        daemonize = arguments.daemonize ? arguments.daemonize.to_b : true
        system("cd ./lib/ruby_app; mkdir -p ./process/thin/log ./process/thin/pid; bundle exec thin --rackup configuration.ru --port 8000 --log ./process/thin/log/thin.log --pid ./process/thin/pid/thin.pid #{daemonize ? '--daemonize' : nil} start")
      end

      desc 'Stop the server'
      task :stop do |task|
        system('cd ./lib/ruby_app; for pid in ./process/thin/pid/*.pid; do bundle exec thin --pid $pid stop; done')
      end

      desc 'Restart the server'
      task :restart, [:daemonize] => ['ruby_app:process:server:stop',
                                      'ruby_app:process:server:start']

    end

  end

  namespace :script do

    desc 'Run a given script through PhantomJS on a given url'
    task :run, :url, :script do |task, arguments|
      system("phantomjs --ignore-ssl-errors=true lib/ruby_app/scripts/phantom/phantom.js #{arguments.url} #{arguments.script}")
    end

    namespace :standard_no_logon do

      desc 'Run the script through PhantomJS on a given url'
      task :run, :url do |task, arguments|
        Rake::Task['ruby_app:script:run'].invoke(arguments.url, 'phantom/standard_no_logon')
      end

      desc 'Run the script on the local environment'
      task :local do |task|
        Rake::Task['ruby_app:script:standard_no_logon:run'].invoke('http://localhost:8000')
      end

    end

  end

  namespace :cache do

    desc 'List all cached files'
    task :list do
      system('find . | grep \'\\.cache\'')
    end

    desc 'Delete all cached files'
    task :destroy do
      system('find . -name \'.cache\' | xargs rm -rv')
    end

  end


end
