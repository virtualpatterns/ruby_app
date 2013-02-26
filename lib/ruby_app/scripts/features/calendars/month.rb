load_script! 'common/features'

add_step! (RubyApp::Element::Event)                     { |event| event.assert_exists_link('Calendars') } 
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('Calendars') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_link('Month') } 
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('Month') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_link(Date.today.day == 15 ? 14 : 15) } 
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link(Date.today.day == 15 ? 14 : 15) }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_text("You selected day #{Date.today.day == 15 ? 14 : 15}.") } 
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.assert_exists_link('OK') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('OK') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_text(Date.today.day == 15 ? 14 : 15) } 
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.click_link('Back') } 
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.click_link('Back') } 
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.execute {} } 
