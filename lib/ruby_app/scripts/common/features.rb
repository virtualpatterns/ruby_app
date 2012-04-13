add_step! (RubyApp::Elements::Mobile::Page::LoadedEvent)  { |event| event.assert_exists_link('Features') }
add_step! (RubyApp::Element::AssertedEvent)               { |event| event.tap_link('Features') }
