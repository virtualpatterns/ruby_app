// /Users/fficnar/Dropbox/Projects/gems/ruby_app/lib/ruby_app/elements/lists/select.js.haml
$(document).ready(function() {
  $('ul.select > li.item > a.item').live('click', function(event) {
    event.preventDefault();
    RubyApp.queueEvent({_class:'RubyApp::Elements::List::ClickedEvent', source_id:$(this).parents('ul.select').attr('id'), index:$(this).attr('index')}, true);
  });
});

