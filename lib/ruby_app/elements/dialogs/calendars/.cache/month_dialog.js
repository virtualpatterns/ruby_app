// /Users/fficnar/Dropbox/Projects/gems/ruby_app/lib/ruby_app/elements/calendars/base/base_month.js.haml
$(document).ready(function() {
  $('div.month > table > thead > tr > td.left > a.previous').live('click', function(event) {
    event.preventDefault();
    RubyApp.queueEvent({_class:'RubyApp::Elements::Calendars::Month::MovedEvent', source_id:$(this).parents('div.month').attr('id'), unit:'month', amount:-1}, true);
  });
  $('div.month > table > thead > tr > td.right > a.next').live('click', function(event) {
    event.preventDefault();
    RubyApp.queueEvent({_class:'RubyApp::Elements::Calendars::Month::MovedEvent', source_id:$(this).parents('div.month').attr('id'), unit:'month', amount:1}, true);
  });
  $('div.month > table > tbody > tr > td > a.day').live('click', function(event) {
    event.preventDefault();
    RubyApp.queueEvent({_class:'RubyApp::Elements::Calendars::Month::ChangedEvent', source_id:$(this).parents('div.month').attr('id'), date:$(this).attr('date')}, true);
  });
});


