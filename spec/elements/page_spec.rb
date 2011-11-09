require 'spec_helper'

require 'ruby_app/elements/page'

describe RubyApp::Elements::Page do
  include_context 'RubyApp::Request'

  describe 'positive' do

    describe 'render instance' do

      let(:page) { RubyApp::Elements::Page.new }

      specify { page.should respond_to(:interval) }

    end

  end

end
