require 'spec_helper'

require 'ruby_app/log'

describe RubyApp::Log do
  include_context 'RubyApp::Application'

  describe 'positive' do

    describe 'class' do

      specify { RubyApp::Log.should respond_to('open!') }
      specify { RubyApp::Log.should respond_to('get') }
      specify { RubyApp::Log.should respond_to('close!') }

      specify { RubyApp::Log.get.should_not be_nil }

    end

  end

  describe 'negative' do
  end

end
