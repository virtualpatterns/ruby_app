require 'spec_helper'

require 'ruby_app/elements'

describe RubyApp::Element do
  include_context 'request'

  describe 'positive' do

    before(:all) do

      class BaseElement < RubyApp::Element
        template_path(:all, File.dirname(__FILE__))
      end

      class DerivedElement < BaseElement
        template_path(:all, File.dirname(__FILE__))
      end

      class ContainerElement < RubyApp::Element

        template_path(:all, File.dirname(__FILE__))

        def initialize
          super

          @derived_element_1 = DerivedElement.new
          @derived_element_2 = DerivedElement.new

        end

      end

    end

    describe 'BaseElement' do

      describe 'render instance' do

        let(:base_element) { BaseElement.new }

        describe 'render html' do

          specify { base_element.render(:html).should include('BaseElement') }
          specify { base_element.render(:html).scan(/BaseElement/).length.should == 1 }

          it 'generates ouput' do
            puts '-' *80
            puts base_element.render(:html)
            puts '-' *80
          end

        end

      end

    end

    describe 'DerivedElement' do

      describe 'render instance' do

        let(:derived_element) { DerivedElement.new }

        describe 'render html' do

          it 'generates ouput' do
            puts '-' *80
            puts derived_element.render(:html)
            puts '-' *80
          end

        end

      end

    end

    describe 'ContainerElement' do

      describe 'render instance' do

        let(:container_element) { ContainerElement.new }

        describe 'render html' do

          it 'generates ouput' do
            puts '-' *80
            puts container_element.render(:html)
            puts '-' *80
          end

        end

      end

    end

  end

end
