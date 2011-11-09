require 'spec_helper'

require 'ruby_app/element'

describe RubyApp::Element do
  include_context 'RubyApp::Request'

  describe RubyApp::Element::Event do

    describe 'positive' do

      describe 'class' do

        specify { RubyApp::Element::Event.should respond_to('from_hash') }

      end

      describe 'instance' do

        let(:element) { RubyApp::Element.new }
        let(:event) { RubyApp::Element::Event.new('source_id' => element.element_id) }

        specify { event.should respond_to('source') }
        specify { event.source.should_not be_nil }
        specify { event.source.should == element }

        specify { event.should respond_to('process!') }
        specify { event.should respond_to('alert') }
        specify { event.should respond_to('refresh') }
        specify { event.should respond_to('show') }
        specify { event.should respond_to('hide') }
        specify { event.should respond_to('update_element') }
        specify { event.should respond_to('update_text') }
        specify { event.should respond_to('update_value') }
        specify { event.should respond_to('go') }
        specify { event.should respond_to('execute') }
        specify { event.should respond_to('to_hash') }

      end

    end

    describe 'negative' do

    end

  end

  describe 'positive' do

    describe 'class' do

      specify { RubyApp::Element.should respond_to('get_element') }

    end

    describe 'instance' do

      let(:element) { RubyApp::Element.new }

      specify { element.should respond_to('attributes') }
      specify { RubyApp::Element.get_element(element.element_id).should == element }

    end

  end

  describe 'negative' do
  end

end
