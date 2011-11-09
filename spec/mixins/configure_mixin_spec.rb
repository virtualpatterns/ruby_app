require 'spec_helper'

require 'ruby_app/mixins/configure_mixin'

describe RubyApp::Mixins::ConfigureMixin do
  include_context 'RubyApp::Request'

  describe 'positive' do

    before(:all) do

      class TestConfigureMixin
        include RubyApp::Mixins::ConfigureMixin
      end

    end

    let(:instance_a) { TestConfigureMixin.new }

    specify { instance_a.should respond_to(:configure) }

  end

end
