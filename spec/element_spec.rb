require 'spec_helper'

require 'ruby_app/application'
require 'ruby_app/element'

describe RubyApp::Element do
  include_context 'RubyApp::Elements'

  let(:element) { RubyApp::Element.new }

  describe 'positive' do

    describe 'get element by element_id' do
      specify { RubyApp::Application.execute(environment) { RubyApp::Element.get_element(element.element_id).should == element } }
    end

  end

  describe 'negative' do
  end

end
