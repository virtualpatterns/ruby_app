load_script! 'common/information'

add_step! (RubyApp::Element::Event)                     { |event| event.assert_exists_link('Sessions') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('Sessions') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_link('(current)') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('(current)') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_link('Documents') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('Documents') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_link('DefaultDocument') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('DefaultDocument') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_link('Pages') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('Pages') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_link('DefaultPage') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('DefaultPage') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_text('DefaultPage') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.execute {} }
