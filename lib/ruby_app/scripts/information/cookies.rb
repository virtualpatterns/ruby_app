load_script! 'common/information'

add_step! (RubyApp::Element::Event)                     { |event| event.assert_exists_link('Cookies') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('Cookies') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_text('_session') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.execute {} }
