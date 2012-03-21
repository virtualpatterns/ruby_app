require 'spec_helper'

describe 'request' do
  include_context 'request'

  describe 'positive' do

    specify { RubyApp::Request.get.should_not be_nil }
    specify { RubyApp::Response.get.should_not be_nil }
    specify { RubyApp::Language.get.should_not be_nil }
    specify { RubyApp::Session.get.should_not be_nil }

  end

  describe 'negative' do
  end

end
