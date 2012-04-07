load! 'common/features'

step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_link('Trigger')
  event.tap_link('Trigger')
end

step! RubyApp::Element::TriggeredEvent do |event|
  event.tap_link('Back')
end

step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.tap_link('Back')
end

step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.refresh
end
