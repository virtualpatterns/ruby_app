require 'rubygems'
require 'bundler/setup'

require 'haml'

require 'ruby_app/mixins/render'
require 'ruby_app/mixins/template'

describe RubyApp::Mixins::Render do

  before(:all) do

    class TestA
      extend RubyApp::Mixins::Template
      include Haml::Helpers
      extend Haml::Helpers
      extend RubyApp::Mixins::Render
      include RubyApp::Mixins::Render
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

    class TestE
      extend RubyApp::Mixins::Template
      include Haml::Helpers
      extend Haml::Helpers
      extend RubyApp::Mixins::Render
      include RubyApp::Mixins::Render
      template_path(:all, File.dirname(__FILE__))
    end

    class TestF < TestE
      template_path(:all, File.dirname(__FILE__))
    end

    class TestG < TestB
      template_path(:all, File.dirname(__FILE__))
    end

  end

  describe 'positive' do

    describe 'render a class' do

      specify { TestA.render(:html).should include('<!-- TestA -->') }
      specify { TestA.render(:html).scan(/TestA/).length.should == 1 }
      specify { TestA.render(:css).should include('/* TestA */') }
      specify { TestA.render(:css).scan(/TestA/).length.should == 1 }
      specify { TestA.render(:js).should include('// TestA') }
      specify { TestA.render(:js).scan(/TestA/).length.should == 1 }

      describe 'render an including all derived class' do

        specify { TestB.render(:html).should include('<!-- TestA -->') }
        specify { TestB.render(:html).should include('<!-- TestB -->') }
        specify { TestB.render(:css).should include('/* TestA */') }
        specify { TestB.render(:css).should include('/* TestB */') }
        specify { TestB.render(:js).should include('// TestA') }
        specify { TestB.render(:js).should include('// TestB') }

        specify { TestF.render(:html).scan(/TestF/).length.should == 1 }
        specify { TestF.render(:html).scan(/TestF/).length.should == 1 }
        specify { TestF.render(:html).scan(/TestF/).length.should == 1 }

      end

      describe 'render an including some derived class' do

        specify { TestC.render(:html).should include('<!-- TestC -->') }
        specify { TestC.render(:css).should include('/* TestA */') }
        specify { TestC.render(:css).should include('/* TestC */') }
        specify { TestC.render(:js).should include('// TestA') }
        specify { TestC.render(:js).should include('// TestC') }

      end

      describe 'render a derived class with no templates' do

        specify { TestD.render(:html).should include('<!-- TestC -->') }
        specify { TestD.render(:css).should include('/* TestA */') }
        specify { TestD.render(:css).should include('/* TestC */') }
        specify { TestD.render(:js).should include('// TestA') }
        specify { TestD.render(:js).should include('// TestC') }

      end

      describe 'render a derived class in multiple threads' do

        specify { TestG.render(:css).should include('/* TestA */') }
        specify { TestG.render(:css).should include('/* TestB */') }
        specify { TestG.render(:css).should include('/* TestG */') }

      end

    end

    describe 'render an instance' do

      let(:instance_a) { TestA.new }
      let(:instance_b) { TestB.new }
      let(:instance_c) { TestC.new }
      let(:instance_d) { TestD.new }
      let(:instance_e) { TestE.new }
      let(:instance_f) { TestF.new }

      specify { instance_a.render(:html).should include('<!-- TestA -->') }
      specify { instance_a.render(:html).scan(/TestA/).length.should == 1 }
      specify { instance_a.render(:css).should include('/* TestA */') }
      specify { instance_a.render(:css).scan(/TestA/).length.should == 1 }
      specify { instance_a.render(:js).should include('// TestA') }
      specify { instance_a.render(:js).scan(/TestA/).length.should == 1 }

      describe 'render an include all derived instance' do

        specify { instance_b.render(:html).should include('<!-- TestA -->') }
        specify { instance_b.render(:html).should include('<!-- TestB -->') }
        specify { instance_b.render(:css).should include('/* TestA */') }
        specify { instance_b.render(:css).should include('/* TestB */') }
        specify { instance_b.render(:js).should include('// TestA') }
        specify { instance_b.render(:js).should include('// TestB') }

        specify { instance_f.render(:html).scan(/TestF/).length.should == 1 }
        specify { instance_f.render(:html).scan(/TestF/).length.should == 1 }
        specify { instance_f.render(:html).scan(/TestF/).length.should == 1 }

      end

      describe 'render an include some derived instance' do

        specify { instance_c.render(:html).should include('<!-- TestC -->') }
        specify { instance_c.render(:css).should include('/* TestA */') }
        specify { instance_c.render(:css).should include('/* TestC */') }
        specify { instance_c.render(:js).should include('// TestA') }
        specify { instance_c.render(:js).should include('// TestC') }

      end

      describe 'render a derived instance with no templates' do

        specify { instance_d.render(:html).should include('<!-- TestC -->') }
        specify { instance_d.render(:css).should include('/* TestA */') }
        specify { instance_d.render(:css).should include('/* TestC */') }
        specify { instance_d.render(:js).should include('// TestA') }
        specify { instance_d.render(:js).should include('// TestC') }

      end

    end

  end

  describe 'negative' do

    describe 'should not render a class' do

      describe 'should not render an include some derived class' do

        specify { TestC.render(:html).should_not include('<!-- TestA -->') }

      end

    end

    describe 'should not render an instance' do

      let(:instance_c) { TestC.new }

      describe 'should not render an include some derived instance' do

        specify { instance_c.render(:html).should_not include('<!-- TestA -->') }

      end

    end

  end

end
