step! (RubyApp::Elements::Mobile::Document::LoadedEvent)  { |event| event.assert_exists_link('Features') }
step! (RubyApp::Element::AssertedEvent)                   { |event| event.assert_exists_link('Information') }
step! (RubyApp::Element::AssertedEvent)                   { |event| event.refresh }
