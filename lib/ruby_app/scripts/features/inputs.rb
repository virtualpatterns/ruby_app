load_script! 'common/features'

add_step! (RubyApp::Element::Event)                     { |event| event.assert_exists_link('Inputs') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('Inputs') }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_input('Simple Input') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.assert_not_exists_input('Null') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.update_input('Simple Input', 'value') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_text('You input value.') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.assert_exists_link('OK') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('OK') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_input('Simple Input', 'value') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.assert_not_exists_input('Simple Input', 'null') }

add_step! (RubyApp::Element::AssertedEvent)             { |event| event.assert_exists_input('Duration Input') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.update_input('Duration Input', '2h 3m') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_text('You input 7380.') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.assert_exists_link('OK') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('OK') }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_input('Email Input') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.update_input('Email Input', 'value') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_text('You input value.') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.assert_exists_link('OK') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('OK') }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_input('Date Input') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.update_input('Date Input', '1/1/1970') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_text('You input 1/1/1970.') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.assert_exists_link('OK') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('OK') }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_input('Multiline Input') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.update_input('Multiline Input', 'value') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_text('You input value.') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.assert_exists_link('OK') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('OK') }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_input('Toggle Input', 'false') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.update_input('Toggle Input', 'true') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_text('You input true.') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.assert_exists_link('OK') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('OK') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_input('Toggle Input', 'true') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.update_input('Toggle Input', 'false') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_text('You input false.') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.assert_exists_link('OK') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('OK') }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.execute {} }
