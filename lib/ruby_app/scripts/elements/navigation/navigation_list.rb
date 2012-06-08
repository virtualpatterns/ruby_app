load_script! 'common/features'

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_link('Navigation') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('Navigation') }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_link('List') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('List') }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_link('NavigatedPage') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('NavigatedPage') }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_text('You are on this page.') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('Back') }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.refresh_browser }
