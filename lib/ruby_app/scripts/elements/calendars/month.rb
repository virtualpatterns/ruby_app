load_script! 'common/features'

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_link('Calendars')
  event.tap_link('Calendars')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_link('Month')
  event.tap_link('Month')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_link(Date.today.day == 15 ? 14 : 15)
  event.tap_link(Date.today.day == 15 ? 14 : 15)
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_text("You selected day #{Date.today.day == 15 ? 14 : 15}.")
  event.assert_exists_link('OK')
  event.tap_link('OK')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_text(Date.today.day == 15 ? 14 : 15)
  event.tap_link('Back')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.tap_link('Back')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.tap_link('Back')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.refresh_browser
end
