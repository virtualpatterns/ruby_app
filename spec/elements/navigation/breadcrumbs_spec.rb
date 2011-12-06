require 'spec_helper'

require 'ruby_app/application'
require 'ruby_app/element'
require 'ruby_app/elements/navigation/breadcrumbs'
require 'ruby_app/elements/pages/default_page'
require 'ruby_app/elements/pages/test_pages/default_test_page'
require 'ruby_app/session'

describe RubyApp::Elements::Navigation::Breadcrumbs do
  include_context 'RubyApp::Request'

  describe 'positive' do

    describe 'class' do

      specify { RubyApp::Elements::Navigation::Breadcrumbs.render(:css).should be_nil }
      specify { RubyApp::Elements::Navigation::Breadcrumbs.render(:js).should_not be_nil }

    end

    describe 'instance' do

      let(:breadcrumbs) { RubyApp::Elements::Navigation::Breadcrumbs.new }

      specify { breadcrumbs.render(:html).should_not be_nil }

    end

    describe 'pages' do

      before(:all) do
        RubyApp::Session.pages.push(RubyApp::Elements::Pages::TestPages::DefaultTestPage.new)
      end

      let(:breadcrumbs) { RubyApp::Elements::Navigation::Breadcrumbs.new }
      let(:first_page) { RubyApp::Session.pages.first }
      let(:second_page) { RubyApp::Session.pages.last }

      specify { RubyApp::Session.pages.length.should == 2 }
      specify { breadcrumbs.render(:html).should include(first_page.translate.title) }
      specify { breadcrumbs.render(:html).should include(second_page.translate.title) }

      describe 'event' do

        before(:all) do
          RubyApp::Element::Event.from_hash({ 'now' => Time.now.to_s,
                                              '_class' => 'RubyApp::Elements::Navigation::Base::BaseBreadcrumbs::ClickedEvent',
                                              'source_id' => breadcrumbs.element_id,
                                              'page_id' => first_page.element_id }).process!
        end

        specify { RubyApp::Session.pages.length.should == 1 }
        specify { RubyApp::Session.pages.last.should == first_page }

      end

    end

  end

end
