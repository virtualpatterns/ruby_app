require 'ruby_app/mixins/route_mixin'

describe RubyApp::Mixins::RouteMixin do

  before(:all) do
    Object.extend RubyApp::Mixins::RouteMixin
  end

  before(:each) do
    @value = false
    @parameters = nil
    Object.clear_routes
  end

  describe 'positive' do

    it 'should match a blank pattern on GET' do
      Object.route(RubyApp::Mixins::RouteMixin::GET, /^$/) { @value = true }
      @value.should be_false
      Object.do_route(RubyApp::Mixins::RouteMixin::GET, '')
      @value.should be_true
    end

    it 'should match a pattern on GET' do
      Object.route(RubyApp::Mixins::RouteMixin::GET, /^pattern$/) { @value = true }
      @value.should be_false
      Object.do_route(RubyApp::Mixins::RouteMixin::GET, 'pattern')
      @value.should be_true
    end

    it 'should match a pattern on POST' do
      Object.route(RubyApp::Mixins::RouteMixin::POST, /^pattern$/) { @value = true }
      @value.should be_false
      Object.do_route(RubyApp::Mixins::RouteMixin::POST, 'pattern')
      @value.should be_true
    end

    it 'should match a pattern on GET with a parameter' do
      Object.route(RubyApp::Mixins::RouteMixin::GET, /^pattern (.*)$/) { |method, path, parameter| @value, @parameters = true, parameter }
      @value.should be_false
      @parameter.should be_nil
      Object.do_route(RubyApp::Mixins::RouteMixin::GET, 'pattern parameter')
      @value.should be_true
      @parameters.should == 'parameter'
    end

  end

  describe 'negative' do

    it 'should not match a not matching pattern on GET' do
      Object.route(RubyApp::Mixins::RouteMixin::GET, /^pattern$/) { @value = true }
      @value.should be_false
      Object.do_route(RubyApp::Mixins::RouteMixin::GET, 'not matching pattern')
      @value.should be_false
    end

  end

end
