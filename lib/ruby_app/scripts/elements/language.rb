load_script! 'common/features'

add_step! (RubyApp::Element::Event)                       { |event| event.assert_exists_link('Language') }
add_step! (RubyApp::Element::AssertedEvent)               { |event| event.click_link('Language') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)   { |event| event.go("#{RubyApp::Application.root}/en") }
add_step! (RubyApp::Elements::Mobile::Page::LoadedEvent)  { |event| event.assert_exists_link('Back') }
add_step! (RubyApp::Element::AssertedEvent)               { |event| event.go("#{RubyApp::Application.root}/fr") }
add_step! (RubyApp::Elements::Mobile::Page::LoadedEvent)  { |event| event.assert_exists_link('Reculer') }
add_step! (RubyApp::Element::AssertedEvent)               { |event| event.go(RubyApp::Application.root) }
add_step! (RubyApp::Elements::Mobile::Page::LoadedEvent)  { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)   { |event| event.click_link('Back') }
add_step! (RubyApp::Elements::Mobile::Page::ShownEvent)   { |event| event.execute {} }
