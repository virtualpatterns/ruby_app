require 'spec_helper'

require 'ruby_app/session'

describe RubyApp::Session do
  include_context 'RubyApp::Request'

  describe 'positive' do

    describe 'class' do

      specify { RubyApp::Session.should respond_to('create!') }
      specify { RubyApp::Session.should respond_to('get') }
      specify { RubyApp::Session.should respond_to('destroy!') }

      specify { RubyApp::Session.get.should_not be_nil }

    end

    describe 'instance' do

      let(:session) { RubyApp::Session.get }

      specify { session.should respond_to('pages') }
      specify { session.should respond_to('[]') }
      specify { session.should respond_to('[]=') }
      specify { session.should respond_to('identity') }
      specify { session.should respond_to('identity=') }
      specify { session.should respond_to('show_dialog') }
      specify { session.should respond_to('quit') }

    end

  end

  describe 'negative' do
  end

end
