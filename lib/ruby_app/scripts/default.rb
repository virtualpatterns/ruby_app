add_step! (RubyApp::Elements::Mobile::Page::LoadedEvent)  { |event| event.execute { RubyApp::Log.info("STEP   Running steps in #{__FILE__}")} }
add_step! (RubyApp::Element::ExecutedEvent)               { |event| event.assert_exists_link('Features') }
add_step! (RubyApp::Element::AssertedEvent)               { |event| event.assert_exists_link('Information') }
add_step! (RubyApp::Element::AssertedEvent)               { |event| event.refresh_browser }
