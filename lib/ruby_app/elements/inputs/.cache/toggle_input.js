// /Users/fficnar/Dropbox/Projects/gems/ruby_app/lib/ruby_app/elements/inputs/toggle_input.js.haml
$(document).ready(function() {
  $('input[type="checkbox"]').live('change', function(event) {
    event.preventDefault();
    RubyApp.queueEvent({_class:'RubyApp::Elements::Inputs::ToggleInput::ChangedEvent', source_id:$(this).attr('id'), value:this.checked}, false);
  });
});

