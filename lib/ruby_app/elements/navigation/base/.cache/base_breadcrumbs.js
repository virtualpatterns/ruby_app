// /Users/fficnar/Dropbox/Projects/gems/ruby_app/lib/ruby_app/elements/navigation/base/base_breadcrumbs.js.haml
$(document).ready(function() {
  $('div.breadcrumbs > a.breadcrumb').click(function(event) {
    event.preventDefault();
    RubyApp.queueEvent({_class:'RubyApp::Elements::Navigation::Breadcrumbs::ClickedEvent', source_id:$(this).parents('div.breadcrumbs').attr('id'), page_id:$(this).attr('page_id')}, true);
  });
});

