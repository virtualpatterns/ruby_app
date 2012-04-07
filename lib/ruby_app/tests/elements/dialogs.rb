load! 'common/features'

step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_link('Dialogs')
  event.tap_link('Dialogs')
end

step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_link('Acknowledgement')
  event.tap_link('Acknowledgement')
end

step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_text('Acknowledge this.')
  event.assert_exists_link('OK')
  event.tap_link('OK')
end

step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_link('Acknowledgement')
  event.assert_exists_link('Confirmation')
  event.tap_link('Confirmation')
end

step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_text('Do you confirm this?')
  event.assert_exists_link('Yes')
  event.assert_exists_link('No')
  event.tap_link('Yes')
end

step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_text('You responded true.')
  event.assert_exists_link('OK')
  event.tap_link('OK')
end

step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_link('Confirmation')
  event.tap_link('Confirmation')
end

step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_text('Do you confirm this?')
  event.tap_link('No')
end

step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_text('You responded false.')
  event.assert_exists_link('OK')
  event.tap_link('OK')
end

step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_link('Confirmation')
  event.assert_exists_link('Exception')
  event.tap_link('Exception')
end

step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_text('The assertion false failed.')
  event.assert_exists_link('Close')
  event.tap_link('Close')
end

step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_link('Exception')
  event.tap_link('Back')
end

step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.tap_link('Back')
end

step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.refresh
end
