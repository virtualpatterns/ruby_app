require 'ruby_app/mixins/hash_mixin'

describe RubyApp::Mixins::HashMixin do

  describe 'positive' do

    before(:all) do

      class TestHashMixin
        include RubyApp::Mixins::HashMixin

        def initialize
          @data = { :get_a => TestHashMixin }
        end

        def [](key)
          @data[key]
        end

        def []=(key, value)
          @data[key] = value
        end

      end

    end

    let(:instance_a) { TestHashMixin.new }

    specify { instance_a.get_a.should == TestHashMixin }

    specify do
      instance_a.get_a = RubyApp::Mixins::HashMixin
      instance_a.get_a.should == RubyApp::Mixins::HashMixin
    end

  end

end
