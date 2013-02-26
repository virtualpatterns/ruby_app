add_step! (RubyApp::Element::Event)                       { |event| event.assert_exists_link('Information') }
add_step! (RubyApp::Element::AssertedEvent)               { |event| event.click_link('Information') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)   { |event| event.assert_exists_text('Information') }
add_step! (RubyApp::Element::AssertedEvent)               { |event| event.execute {} }
