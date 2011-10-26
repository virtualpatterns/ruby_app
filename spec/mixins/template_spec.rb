require 'ruby_app/mixins/template'

describe RubyApp::Mixins::Template do

  before(:all) do

    class TestA
      extend RubyApp::Mixins::Template
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

    specify { TestA.get_templates(:html).should include File.join(File.dirname(__FILE__), %w[test_a.html.haml]) }
    specify { TestA.get_templates(:css).should include File.join(File.dirname(__FILE__), %w[test_a.css.haml]) }
    specify { TestA.get_templates(:js).should include File.join(File.dirname(__FILE__), %w[test_a.js.haml]) }

    describe 'include all parent' do

      specify { TestB.get_templates(:html).should include File.join(File.dirname(__FILE__), %w[test_a.html.haml]) }
      specify { TestB.get_templates(:html).should include File.join(File.dirname(__FILE__), %w[test_b.html.haml]) }
      specify { TestB.get_templates(:css).should include File.join(File.dirname(__FILE__), %w[test_a.css.haml]) }
      specify { TestB.get_templates(:css).should include File.join(File.dirname(__FILE__), %w[test_b.css.haml]) }
      specify { TestB.get_templates(:js).should include File.join(File.dirname(__FILE__), %w[test_a.js.haml]) }
      specify { TestB.get_templates(:js).should include File.join(File.dirname(__FILE__), %w[test_b.js.haml]) }

    end

    describe 'include some parents' do

      specify { TestC.get_templates(:html).should include File.join(File.dirname(__FILE__), %w[test_c.html.haml]) }
      specify { TestC.get_templates(:css).should include File.join(File.dirname(__FILE__), %w[test_a.css.haml]) }
      specify { TestC.get_templates(:css).should include File.join(File.dirname(__FILE__), %w[test_c.css.haml]) }
      specify { TestC.get_templates(:js).should include File.join(File.dirname(__FILE__), %w[test_a.js.haml]) }
      specify { TestC.get_templates(:js).should include File.join(File.dirname(__FILE__), %w[test_c.js.haml]) }

    end

    describe 'with no templates' do

      specify { TestD.get_templates(:html).should include File.join(File.dirname(__FILE__), %w[test_c.html.haml]) }
      specify { TestD.get_templates(:css).should include File.join(File.dirname(__FILE__), %w[test_c.css.haml]) }
      specify { TestD.get_templates(:js).should include File.join(File.dirname(__FILE__), %w[test_c.js.haml]) }

    end

  end

  describe 'negative' do

    specify { TestA.get_templates(:htm).should_not include File.join(File.dirname(__FILE__), %w[test_a.htm.haml]) }
    specify { TestA.get_templates(:sass).should_not include File.join(File.dirname(__FILE__), %w[test_a.scss.haml]) }
    specify { TestA.get_templates(:javascript).should_not include File.join(File.dirname(__FILE__), %w[test_a.javascript.haml]) }

    describe 'include some parents' do

      specify { TestC.get_templates(:html).should_not include File.join(File.dirname(__FILE__), %w[test_a.html.haml]) }

    end

  end

end
