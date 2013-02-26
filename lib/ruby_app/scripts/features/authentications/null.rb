load_script! 'common/features/authentications'

add_step! (RubyApp::Element::Event)                       { |event| event.assert_exists_link('Null') }
add_step! (RubyApp::Element::AssertedEvent)               { |event| event.click_link('Null') }
add_step! (RubyApp::Elements::Mobile::Page::LoadedEvent)  { |event| event.assert_exists_link('Close') }
add_step! (RubyApp::Element::AssertedEvent)               { |event| event.click_link('Close') }
add_step! (RubyApp::Elements::Mobile::Page::LoadedEvent)  { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)   { |event| event.execute {} }
