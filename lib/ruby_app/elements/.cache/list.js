// /Users/fficnar/Dropbox/Projects/gems/ruby_app/lib/ruby_app/elements/list.js.haml
$(document).ready(function() {
  $('ul.list > li.item > a.item').live('click', function(event) {
    event.preventDefault();
    RubyApp.queueEvent({_class:'RubyApp::Elements::List::ClickedEvent', source_id:$(this).parents('ul.list').attr('id'), index:$(this).attr('index')}, true);
  });
});

