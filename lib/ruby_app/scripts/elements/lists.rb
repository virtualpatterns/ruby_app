load_script! 'common/features'

add_step! RubyApp::Element::Event do |event|
  event.assert_exists_link('Lists')
  event.click_link('Lists')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_link('Item 01')
  event.click_list_item('Item 01')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_text('You clicked the item Item 01.')
  event.assert_exists_link('OK')
  event.click_link('OK')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_link('Item 01')
  event.click_list_link('Item 01')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_text('You clicked the link Item 01.')
  event.assert_exists_link('OK')
  event.click_link('OK')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_link('Item 01')
  event.click_link('Back')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.click_link('Back')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.execute {}
end
