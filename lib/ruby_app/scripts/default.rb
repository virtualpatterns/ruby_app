add_step! (RubyApp::Element::Event)                       { |event| event.assert_exists_link('Features') }
add_step! (RubyApp::Element::AssertedEvent)               { |event| event.assert_exists_link('Information') }
add_step! (RubyApp::Element::AssertedEvent)               { |event| event.execute {} }
