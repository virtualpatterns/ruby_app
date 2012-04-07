load! 'common/features'

step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_link('Lists')
  event.tap_link('Lists')
end

step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_link('Item 01')
  event.tap_link('Item 01')
end

step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_text('You clicked Item 01.')
  event.assert_exists_link('OK')
  event.tap_link('OK')
end

step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_link('Item 11')
  event.tap_link('Item 11')
end

step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_text('You clicked Item 11.')
  event.assert_exists_link('OK')
  event.tap_link('OK')
end

step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_link('Item 11')
  event.tap_link('Back')
end

step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.tap_link('Back')
end

step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.refresh
end
