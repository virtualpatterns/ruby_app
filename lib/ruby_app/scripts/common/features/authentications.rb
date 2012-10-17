load_script! 'common/features'

add_step! (RubyApp::Element::Event)                       { |event| event.assert_exists_link('Authentications') }
add_step! (RubyApp::Element::AssertedEvent)               { |event| event.click_link('Authentications') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)   { |event| event.assert_exists_text('Authentications') }
add_step! (RubyApp::Element::AssertedEvent)               { |event| event.execute {} }
