add_step! (RubyApp::Element::Event)                       { |event| event.assert_exists_link('Features') }
add_step! (RubyApp::Element::AssertedEvent)               { |event| event.assert_exists_link('Information') }
add_step! (RubyApp::Element::AssertedEvent)               { |event| event.assert_exists_link('Scripts') }
add_step! (RubyApp::Element::AssertedEvent)               { |event| event.assert_not_exists_link('Null') }
add_step! (RubyApp::Element::AssertedEvent)               { |event| event.execute {} }

add_step! (RubyApp::Element::Event)                       { |event| event.refresh_browser }
add_step! (RubyApp::Elements::Mobile::Page::LoadedEvent)  { |event| event.update_style('div.content', 'color', 'blue')
                                                                    event.add_class('div.content', 'content_bold')
                                                                    event.remove_class('div.content', 'content_bold')
                                                                    event.set_cookie('_version', RubyApp::VERSION)
                                                                    event.log("RubyApp #{RubyApp::VERSION}")
                                                                    event.execute {} }
