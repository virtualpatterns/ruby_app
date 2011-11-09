require 'spec_helper'

require 'ruby_app/application'

describe RubyApp::Application do
  include_context 'RubyApp::Application'

  describe 'positive' do

    describe 'class' do

      specify { RubyApp::Application.should respond_to('create!') }
      specify { RubyApp::Application.should respond_to('get') }
      specify { RubyApp::Application.should respond_to('destroy!') }

      specify { RubyApp::Application.get.should_not be_nil }

    end

  end

  describe 'negative' do
  end

end
