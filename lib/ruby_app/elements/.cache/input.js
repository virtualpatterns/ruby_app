// /Users/fficnar/Dropbox/Projects/gems/ruby_app/lib/ruby_app/elements/input.js.haml
$(document).ready(function() {
  $('input[type="text"]').live('change', function(event) {
    event.preventDefault();
    RubyApp.queueEvent({_class:'RubyApp::Elements::Input::ChangedEvent', source_id:$(this).attr('id'), value:$(this).val()}, false);
  });
});

