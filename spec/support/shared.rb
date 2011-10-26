require 'ruby_app/application'

shared_context 'RubyApp::Elements' do

  before(:all) do
    RubyApp::Application.create
  end

  let(:environment) { {} }

  after(:all) do
    RubyApp::Application.destroy
  end

end
