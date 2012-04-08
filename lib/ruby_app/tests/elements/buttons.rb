load! 'common/features'

step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_link('Buttons') }
step! (RubyApp::Element::AssertedEvent)             { |event| event.tap_link('Buttons') }

step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_link('Button') }
step! (RubyApp::Element::AssertedEvent)             { |event| event.tap_link('Button') }

step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_text('You are on this pagez.') }

step! (RubyApp::Element::AssertedEvent)             { |event| event.tap_link('Back') }
step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.tap_link('Back') }
step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.tap_link('Back') }
step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.refresh }
