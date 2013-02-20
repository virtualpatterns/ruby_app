add_step! (RubyApp::Element::Event)                       { |event| event.now = Time.parse('01 January 1970')
                                                                    event.execute {} }
add_step! (RubyApp::Element::ExecutedEvent)               { |event| event.assert("event.now == Time.parse('01 January 1970')") { event.now == Time.parse('01 January 1970') } }
add_step! (RubyApp::Element::AssertedEvent)               { |event| event.now = nil
                                                                    event.execute {} }
