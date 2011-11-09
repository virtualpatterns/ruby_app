require 'spec_helper'

require 'ruby_app/language'

describe RubyApp::Language do
  include_context 'RubyApp::Request'

  describe 'positive' do

    describe 'class' do

      specify { RubyApp::Language.should respond_to('load!') }
      specify { RubyApp::Language.should respond_to('get') }
      specify { RubyApp::Language.should respond_to('unload!') }

      specify { RubyApp::Language.get.should_not be_nil }

    end

  end

  describe 'negative' do
  end

end
