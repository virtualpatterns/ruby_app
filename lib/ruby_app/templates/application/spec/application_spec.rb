require 'spec_helper'

describe 'application' do
  include_context 'application'

  describe 'positive' do

    specify { RubyApp::Configuration.get.should_not be_nil }
    specify { RubyApp::Log.get.should_not be_nil }
    specify { RubyApp::Application.get.should_not be_nil }

  end

  describe 'negative' do
  end

end
