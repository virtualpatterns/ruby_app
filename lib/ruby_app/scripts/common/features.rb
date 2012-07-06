add_step! (RubyApp::Element::Event)                       { |event| event.assert_exists_link('Features') }
add_step! (RubyApp::Element::AssertedEvent)               { |event| event.click_link('Features') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)   { |event| event.assert_exists_text('Features') }
add_step! (RubyApp::Element::AssertedEvent)               { |event| event.execute {} }
