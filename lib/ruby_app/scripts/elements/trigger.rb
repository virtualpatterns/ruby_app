load_script! 'common/features'

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_link('Trigger')
  event.tap_link('Trigger')
end

add_step! RubyApp::Element::TriggeredEvent do |event|
  event.tap_link('Back')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.tap_link('Back')
end

add_step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.refresh_browser
end
