// /Users/fficnar/Dropbox/Projects/gems/ruby_app/lib/ruby_app/elements/inputs/email_input.js.haml
$(document).ready(function() {
  $('input[type="email"]').live('change', function(event) {
    event.preventDefault();
    RubyApp.queueEvent({_class:'RubyApp::Elements::Inputs::EmailInput::ChangedEvent', source_id:$(this).attr('id'), value:$(this).val()}, false);
  });
});

