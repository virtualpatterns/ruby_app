require 'spec_helper'

require 'ruby_app/mixins/configuration_mixin'

describe RubyApp::Mixins::ConfigurationMixin do
  include_context 'RubyApp::Request'

  describe 'positive' do

    before(:all) do

      class TestConfigurationMixin
        include RubyApp::Mixins::ConfigurationMixin
      end

    end

    let(:instance_a) { TestConfigurationMixin.new }

    specify { instance_a.should respond_to(:configuration) }

  end

end
