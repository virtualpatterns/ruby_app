load_script! 'common/features'

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_link('Trigger')
  event.click_link('Trigger')
end

add_step! RubyApp::Element::TriggeredEvent do |event|
  event.click_link('Back')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.click_link('Back')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.refresh_browser
end
