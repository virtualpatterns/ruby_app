require 'spec_helper'

require 'ruby_app/application'
require 'ruby_app/elements/page'

describe RubyApp::Elements::Page do
  include_context 'RubyApp::Elements'

  describe 'positive' do

    describe 'render instance' do

      let(:page) { RubyApp::Elements::Page.new }

      describe 'render :css' do
        specify { RubyApp::Application.execute(environment) { page.render(:css).should_not be_nil } }
      end

      describe 'render :js' do
        specify { RubyApp::Application.execute(environment) { page.render(:js).should_not be_nil } }
      end

      describe 'render :html' do
        specify { RubyApp::Application.execute(environment) { page.render(:html).should_not be_nil } }
      end

    end

  end

end
