load_script! 'common/features'

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_link('Lists')
  event.tap_link('Lists')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_link('Item 01')
  event.tap_list_item('Item 01')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_text('You clicked the item Item 01.')
  event.assert_exists_link('OK')
  event.tap_link('OK')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_link('Item 01')
  event.tap_list_link('Item 01')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_text('You clicked the link Item 01.')
  event.assert_exists_link('OK')
  event.tap_link('OK')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_link('Item 01')
  event.tap_link('Back')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.tap_link('Back')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.refresh_browser
end
