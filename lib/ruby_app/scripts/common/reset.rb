add_step! RubyApp::Elements::Mobile::Document::LoadedEvent do |event|
  self.reset_script!
  event.refresh_browser
end
