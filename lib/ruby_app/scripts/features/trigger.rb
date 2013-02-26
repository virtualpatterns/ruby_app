load_script! 'common/features'

add_step! (RubyApp::Element::Event)                       { |event| event.assert_exists_link('Trigger') }
add_step! (RubyApp::Element::AssertedEvent)               { |event| event.click_link('Trigger') }
add_step! (RubyApp::Element::TriggeredEvent)              { |event| event.trigger_element(event.source) }
add_step! (RubyApp::Element::TriggeredEvent)              { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)   { |event| event.execute {} }
