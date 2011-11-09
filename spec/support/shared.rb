require 'ruby_app/application'

shared_context 'RubyApp::Application' do

  before(:all) do
    RubyApp::Application.create!
  end

  after(:all) do
    RubyApp::Application.destroy!
  end

end

require 'ruby_app/request'

shared_context 'RubyApp::Request' do
  include_context 'RubyApp::Application'

  before(:each) do
    RubyApp::Request.create!
  end

  after(:each) do
    RubyApp::Request.destroy!
  end

end

