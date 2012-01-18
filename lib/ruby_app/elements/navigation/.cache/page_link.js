// /Users/fficnar/Dropbox/Projects/gems/ruby_app/lib/ruby_app/elements/navigation/page_link.js.haml
$(document).ready(function() {
  $('span.link > a.page').click(function(event) {
    event.preventDefault();
    RubyApp.queueEvent({_class:'RubyApp::Elements::Navigation::PageLink::ClickedEvent', source_id:$(this).parents('span.link').attr('id'), page:$(this).attr('page')}, true);
  });
});

