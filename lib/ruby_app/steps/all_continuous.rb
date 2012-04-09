load_steps! 'all_once'

add_step! (RubyApp::Elements::Mobile::Document::LoadedEvent)  { |event| event.go('/quit?go=%2F%3Fsteps%3Dall_continuous') }
