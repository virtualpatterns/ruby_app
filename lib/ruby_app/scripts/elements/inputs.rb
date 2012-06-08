load_script! 'common/features'

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_link('Inputs')
  event.click_link('Inputs')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_input('Simple Input')
  event.update_input('Simple Input', 'value')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_text('You input value.')
  event.assert_exists_link('OK')
  event.click_link('OK')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_input('Simple Input')
  event.assert_exists_input('Duration Input')
  event.update_input('Duration Input', '2h 3m')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_text('You input 7380.')
  event.assert_exists_link('OK')
  event.click_link('OK')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_input('Duration Input', '2 hrs 3 mins')
  event.assert_exists_input('Email Input')
  event.update_input('Email Input', 'value')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_text('You input value.')
  event.assert_exists_link('OK')
  event.click_link('OK')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_input('Email Input')
  event.assert_exists_input('Multiline Input')
  event.update_input('Multiline Input', 'value')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_text('You input value.')
  event.assert_exists_link('OK')
  event.click_link('OK')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_input('Multiline Input')
  event.assert_exists_input('Toggle Input', 'false')
  event.update_input('Toggle Input', 'true')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_text('You input true.')
  event.assert_exists_link('OK')
  event.click_link('OK')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_input('Toggle Input', 'true')
  event.update_input('Toggle Input', 'false')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_text('You input false.')
  event.assert_exists_link('OK')
  event.click_link('OK')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_input('Toggle Input')
  event.click_link('Back')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.click_link('Back')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.refresh_browser
end
