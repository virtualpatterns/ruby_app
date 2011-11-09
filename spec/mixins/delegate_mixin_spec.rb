require 'ruby_app/mixins/delegate_mixin'

describe RubyApp::Mixins::DelegateMixin do

  describe 'positive' do

    before(:all) do

      class TestDelegateMixin
        extend RubyApp::Mixins::DelegateMixin

        def get_a
          return TestDelegateMixin
        end

        def self.get
          TestDelegateMixin.new
        end

      end

    end

    specify { TestDelegateMixin.get_a.should == TestDelegateMixin }

  end

end
