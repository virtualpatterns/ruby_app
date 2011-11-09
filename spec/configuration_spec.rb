require 'spec_helper'

require 'ruby_app/configuration'

describe RubyApp::Configuration do
  include_context 'RubyApp::Application'

  describe 'positive' do

    describe 'class' do

      specify { RubyApp::Configuration.should respond_to('load!') }
      specify { RubyApp::Configuration.should respond_to('get') }
      specify { RubyApp::Configuration.should respond_to('unload!') }

      specify { RubyApp::Configuration.get.should_not be_nil }

    end

  end

  describe 'negative' do
  end

end
