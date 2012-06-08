load_script! 'common/features'

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_link('Swipe') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('Swipe') }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_text('Swipe left or right.') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.swipe(:left) }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_text('You are on this page.') }

add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.refresh_browser }
