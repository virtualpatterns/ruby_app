// /Users/fficnar/Dropbox/Projects/gems/ruby_app/lib/ruby_app/elements/inputs/multiline_input.js.haml
$(document).ready(function() {
  $('textarea').live('change', function(event) {
    event.preventDefault();
    RubyApp.queueEvent({_class:'RubyApp::Elements::Inputs::MultilineInput::ChangedEvent', source_id:$(this).attr('id'), value:$(this).val()}, false);
  });
});

