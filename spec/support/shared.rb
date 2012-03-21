require 'ruby_app'

shared_context 'application' do

  before(:all) do
    RubyApp::Configuration.load!([File.join(RubyApp::ROOT, %w[configuration.yml])])
    RubyApp::Log.open!
    RubyApp::Application.create!
  end

  after(:all) do
    RubyApp::Application.destroy!
    RubyApp::Log.close!
    RubyApp::Configuration.unload!
  end

end

shared_context 'request' do
  include_context 'application'

  before(:each) do
    RubyApp::Request.create!
    RubyApp::Response.create!
    RubyApp::Language.load!
    RubyApp::Session.load!
  end

  after(:each) do
    RubyApp::Session.unload!
    RubyApp::Language.unload!
    RubyApp::Response.destroy!
    RubyApp::Request.destroy!
  end

end

