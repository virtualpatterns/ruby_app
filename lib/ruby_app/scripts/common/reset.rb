add_step! RubyApp::Elements::Mobile::Page::LoadedEvent do |event|
  self.reset_script!
  event.refresh_browser
end
