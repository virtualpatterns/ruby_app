require 'rubygems'
require 'bundler/setup'

require 'haml'

require 'spec_helper'

require 'ruby_app/mixins/render_mixin'
require 'ruby_app/mixins/template_mixin'

describe RubyApp::Mixins::RenderMixin do
  include_context 'RubyApp::Request'

  before(:all) do

    class TestA
      extend RubyApp::Mixins::TemplateMixin
      extend Haml::Helpers
      include Haml::Helpers
      extend RubyApp::Mixins::RenderMixin
      include RubyApp::Mixins::RenderMixin
      template_path(:all, File.dirname(__FILE__))
    end

    class TestB < TestA
      template_path(:all, File.dirname(__FILE__))
    end

    class TestC < TestA
      template_path(:all, File.dirname(__FILE__))
      exclude_parent_template(:html)
    end

    class TestD < TestC
      template_path(:all, File.dirname(__FILE__))
    end

  end

  describe 'positive' do

    describe 'class' do

      specify { TestA.render(:css).should include('/* TestA */') }
      specify { TestA.render(:css).scan(/TestA/).length.should == 1 }
      specify { TestA.render(:js).should include('// TestA') }
      specify { TestA.render(:js).scan(/TestA/).length.should == 1 }

      describe 'including all derived class' do

        specify { TestB.render(:css).should include('/* TestA */') }
        specify { TestB.render(:css).should include('/* TestB */') }
        specify { TestB.render(:js).should include('// TestA') }
        specify { TestB.render(:js).should include('// TestB') }

      end

      describe 'including some derived class' do

        specify { TestC.render(:css).should include('/* TestA */') }
        specify { TestC.render(:css).should include('/* TestC */') }
        specify { TestC.render(:js).should include('// TestA') }
        specify { TestC.render(:js).should include('// TestC') }

      end

      describe 'render a derived class with no templates' do

        specify { TestD.render(:css).should include('/* TestA */') }
        specify { TestD.render(:css).should include('/* TestC */') }
        specify { TestD.render(:js).should include('// TestA') }
        specify { TestD.render(:js).should include('// TestC') }

      end

    end

    describe 'instance' do

      let(:instance_a) { TestA.new }
      let(:instance_b) { TestB.new }
      let(:instance_c) { TestC.new }
      let(:instance_d) { TestD.new }

      specify { instance_a.render(:html).should include('<!-- TestA -->') }
      specify { instance_a.render(:html).scan(/TestA/).length.should == 1 }

      describe 'include all derived instance' do

        specify { instance_b.render(:html).should include('<!-- TestA -->') }
        specify { instance_b.render(:html).should include('<!-- TestB -->') }

      end

      describe 'include some derived instance' do

        specify { instance_c.render(:html).should include('<!-- TestC -->') }

      end

      describe 'render a derived instance with no templates' do

        specify { instance_d.render(:html).should include('<!-- TestC -->') }

      end

    end

  end

  describe 'negative' do

    describe 'instance' do

      describe 'should not include some derived instance' do

        let(:instance_c) { TestC.new }

        specify { instance_c.render(:html).should_not include('<!-- TestA -->') }

      end

    end

  end

end
