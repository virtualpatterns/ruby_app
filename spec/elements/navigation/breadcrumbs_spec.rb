require 'spec_helper'

require 'ruby_app/application'
require 'ruby_app/element'
require 'ruby_app/elements/navigation/breadcrumbs'
require 'ruby_app/elements/pages/default_page'
require 'ruby_app/elements/pages/test_pages/default_test_page'
require 'ruby_app/session'

describe RubyApp::Elements::Navigation::Breadcrumbs do
  include_context 'RubyApp::Elements'

  describe 'positive' do

    describe 'render class' do

      describe 'render :css' do
        specify { RubyApp::Application.execute(environment) { RubyApp::Elements::Navigation::Breadcrumbs.render(:css).should be_nil } }
      end

      describe 'render :js' do
        specify { RubyApp::Application.execute(environment) { RubyApp::Elements::Navigation::Breadcrumbs.render(:js).should_not be_nil } }
      end

    end

    describe 'render instance' do

      let(:breadcrumbs) { RubyApp::Elements::Navigation::Breadcrumbs.new }

      describe 'render :html' do
        specify { RubyApp::Application.execute(environment) { breadcrumbs.render(:html).should_not be_nil } }
      end

    end

    describe 'breadcrumb pages' do

      before(:all) do
        RubyApp::Application.execute(environment) { RubyApp::Session.pages.push(RubyApp::Elements::Pages::TestPages::DefaultTestPage.new) }
      end

      let(:breadcrumbs) { RubyApp::Elements::Navigation::Breadcrumbs.new }
      let(:first_page) { RubyApp::Session.pages.first }
      let(:second_page) { RubyApp::Session.pages.last }

      specify { RubyApp::Application.execute(environment) { breadcrumbs.render(:html).should include(first_page.translate.title) } }
      specify { RubyApp::Application.execute(environment) { breadcrumbs.render(:html).should include(second_page.translate.title) } }

      describe 'send navigated event' do

        before(:all) do
          RubyApp::Application.execute(environment) do
            RubyApp::Session.process(RubyApp::Element::Event.from_hash({ '_class' => 'RubyApp::Elements::Navigation::Base::BaseBreadcrumbs::NavigatedEvent',
                                                                         'source_id' => breadcrumbs.element_id,
                                                                         'page_id' => first_page.element_id }))
          end
        end

        specify { RubyApp::Application.execute(environment) { RubyApp::Session.pages.length.should == 1 } }
        specify { RubyApp::Application.execute(environment) { RubyApp::Session.pages.last.should == first_page } }

      end

    end

  end

end
