load! 'common/features'

step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_link('Buttons')
  event.tap_link('Buttons')
end

step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_link('Button')
  event.tap_link('Button')
end

step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.assert_exists_text('You are on this page.')
  event.tap_link('Back')
end

step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.tap_link('Back')
end

step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.tap_link('Back')
end

step! RubyApp::Elements::Mobile::Page::ShownEvent do |event|
  event.refresh
end
