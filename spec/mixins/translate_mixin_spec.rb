require 'spec_helper'

require 'ruby_app/mixins/translate_mixin'

describe RubyApp::Mixins::TranslateMixin do
  include_context 'RubyApp::Request'

  describe 'positive' do

    before(:all) do

      class TestTranslateMixin
        include RubyApp::Mixins::TranslateMixin
      end

    end

    let(:instance_a) { TestTranslateMixin.new }

    specify { instance_a.should respond_to(:translate) }
    specify { instance_a.should respond_to(:localize) }

  end

end
