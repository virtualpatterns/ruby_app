load_script! 'common/information'

add_step! (RubyApp::Element::Event)                     { |event| event.assert_exists_link('Configuration') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('Configuration') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_text('ruby_app: (Hash)') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.execute {} }
