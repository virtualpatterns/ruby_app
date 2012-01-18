// /Users/fficnar/Dropbox/Projects/gems/ruby_app/lib/ruby_app/elements/markdown.js.haml
$(document).ready(function() {
  $('div.markdown a').live('click', function(event) {
    event.preventDefault();
    RubyApp.queueEvent({_class:'RubyApp::Elements::Markdown::ClickedEvent', source_id:$(this).parents('div.markdown').attr('id'), name:$(this).attr('href')}, true);
  });
});

