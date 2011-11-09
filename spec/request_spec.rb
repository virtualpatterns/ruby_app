require 'spec_helper'

require 'ruby_app/request'

describe RubyApp::Request do
  include_context 'RubyApp::Request'

  describe 'positive' do

    describe 'class' do

      specify { RubyApp::Request.should respond_to('create!') }
      specify { RubyApp::Request.should respond_to('get') }
      specify { RubyApp::Request.should respond_to('destroy!') }

      specify { RubyApp::Request.get.should_not be_nil }

    end

  end

  describe 'negative' do
  end

end
