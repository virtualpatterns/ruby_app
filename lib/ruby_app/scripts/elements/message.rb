load_script! 'common/features'

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)   { |event| event.assert_exists_link('Message') }
add_step! (RubyApp::Element::AssertedEvent)               { |event| event.click_link('Message') }
add_step! (RubyApp::Element::MessagedEvent)               { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)   { |event| event.refresh_browser }
