load_script! 'common/features'

add_step! RubyApp::Element::Event do |event|
  event.assert_exists_link('Calendars')
  event.click_link('Calendars')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_link('Month')
  event.click_link('Month')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_link(Date.today.day == 15 ? 14 : 15)
  event.click_link(Date.today.day == 15 ? 14 : 15)
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_text("You selected day #{Date.today.day == 15 ? 14 : 15}.")
  event.assert_exists_link('OK')
  event.click_link('OK')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_text(Date.today.day == 15 ? 14 : 15)
  event.click_link('Back')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.click_link('Back')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.click_link('Back')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.execute {}
end
