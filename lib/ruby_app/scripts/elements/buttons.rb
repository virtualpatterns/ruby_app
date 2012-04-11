load_script! 'common/features'

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_link('Buttons') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.tap_link('Buttons') }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_link('Button') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.tap_link('Button') }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_text('You are on this page.') }

add_step! (RubyApp::Element::AssertedEvent)             { |event| event.tap_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.tap_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.tap_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.refresh_browser }
