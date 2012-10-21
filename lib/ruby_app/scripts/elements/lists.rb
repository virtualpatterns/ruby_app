load_script! 'common/features'

add_step! (RubyApp::Element::Event)                     { |event| event.assert_exists_link('Lists') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('Lists') }

add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_search('search') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.update_search('search', 'value') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_text('You input value.') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.assert_exists_link('OK') }
add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('OK') }

# add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_link('Item 01') }
# add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_list_item('Item 01') }
# add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_text('You clicked the item Item 01.') }
# add_step! (RubyApp::Element::AssertedEvent)             { |event| event.assert_exists_link('OK') }
# add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('OK') }

# add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_not_exists_link('Item 04') }

# add_step! (RubyApp::Element::AssertedEvent)             { |event| event.assert_exists_link('Item 05') }
# add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_list_item('Item 05') }
# add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_text('You clicked the item Item 05.') }
# add_step! (RubyApp::Element::AssertedEvent)             { |event| event.assert_exists_link('OK') }
# add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('OK') }
# add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_link('Item 05') }
# add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_list_link('Item 05') }
# add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_exists_text('You clicked the link Item 05.') }
# add_step! (RubyApp::Element::AssertedEvent)             { |event| event.assert_exists_link('OK') }
# add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('OK') }

# add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.assert_not_exists_link('Item 08') }

# add_step! (RubyApp::Element::AssertedEvent)             { |event| event.click_link('Back') }
# add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.click_link('Back') }
# add_step! (RubyApp::Elements::Mobile::Page::ShownEvent) { |event| event.execute {} }
