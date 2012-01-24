require 'spec_helper'

require 'ruby_app/mixins/configuration_mixin'

describe RubyApp::Mixins::ConfigurationMixin do
  include_context 'RubyApp::Request'

  describe 'positive' do

    before(:all) do

      class TestConfigureMixin
        include RubyApp::Mixins::ConfigurationMixin
      end

    end

    let(:instance_a) { TestConfigureMixin.new }

    specify { instance_a.should respond_to(:configure) }

  end

end
