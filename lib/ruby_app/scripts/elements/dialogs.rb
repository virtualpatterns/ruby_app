load_script! 'common/features'

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_link('Dialogs') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('Dialogs') }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_link('Acknowledgement') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('Acknowledgement') }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_text('Acknowledge this.') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.assert_exists_link('OK') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('OK') }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_link('Acknowledgement') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.assert_exists_link('Confirmation') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('Confirmation') }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_text('Do you confirm this?') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.assert_exists_link('Yes') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.assert_exists_link('No') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('Yes') }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_text('You responded true.') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.assert_exists_link('OK') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('OK') }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_link('Confirmation') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('Confirmation') }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_text('Do you confirm this?') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('No') }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_text('You responded false.') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.assert_exists_link('OK') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('OK') }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_link('Confirmation') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.assert_exists_link('Exception') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('Exception') }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_text('This is an exception.') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.assert_exists_link('OK') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('OK') }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_link('Month') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('Month') }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_link(Date.today.day == 15 ? 14 : 15) }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link(Date.today.day == 15 ? 14 : 15) }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_text("You responded day #{Date.today.day == 15 ? 14 : 15}.") }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.assert_exists_link('OK') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('OK') }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_link('Month') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('Month') }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_link('Today') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('Today') }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_text("You responded day #{Date.today.day}.") }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.assert_exists_link('OK') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('OK') }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_link('Month') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('Back') }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.click_link('Back') }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.refresh_browser }
