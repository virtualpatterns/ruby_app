add_step! RubyApp::Element::Event do |event|
  self.reset_script!
  event.execute {}
end
