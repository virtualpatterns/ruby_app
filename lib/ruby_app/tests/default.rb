step! RubyApp::Elements::Mobile::Document::LoadedEvent do |event|
  event.assert_exists_link('Features')
  event.assert_exists_link('Information')
end

step! RubyApp::Element::AssertedEvent

step! RubyApp::Element::AssertedEvent do |event|
  event.refresh
end
