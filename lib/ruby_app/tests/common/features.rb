step! RubyApp::Elements::Mobile::Document::LoadedEvent do |event|
  event.assert_exists_link('Features')
end

step! RubyApp::Element::AssertedEvent do |event|
  event.tap_link('Features')
end
