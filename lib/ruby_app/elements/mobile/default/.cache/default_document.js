// /Users/frank.ficnar/Dropbox/Projects/gems/ruby_app/lib/ruby_app/elements/mobile/document.js.haml
var RubyApp = new function() {
  this.queueEvent = function(event) {
    event.now = new Date().toString();
    event.session = RubyApp.getData('session', null);
    $(window).queue( function() {
      RubyApp.log('RubyApp.queueEvent(...) DEQUEUE event.class=' + event._class);
      request = $.ajax({type:'POST', url:location.href, data:event});
      request
        .success( function(event) {
          $.each(event.statements, function(index, statement) {
            RubyApp.log('RubyApp.queueEvent(...) EVAL    statement="' + statement + '"')
            eval(statement);
          } );
        } )
        .error( function(request, message, exception) {
          RubyApp.log('RubyApp.queueEvent(...) ERROR   event.class=' + event._class +' message=' + message);
          RubyApp.confirmRefreshBrowser(RubyApp.getData('event_error_message', null));
        } )
        .complete( function() {
          $(window).dequeue();
        } )
    } );
  },
  this.showPage = function(id, options) {
    $(window).clearQueue();
    if ($('#' + id).length)
      $.mobile.changePage($('#' + id), options);
    else
    {
      request = $.ajax({type:'GET', url:'/' + RubyApp.getData('locale', 'en') + '/elements/' + id + '.html'});
      request
        .success( function(content) {
          $('body').prepend(content);
          $.mobile.changePage($('#' + id), options);
        } );
    }
  },
  this.removePage = function(id) {
    $(document).on('pagehide.removePage', '#' + id, function(event) {
      $(document).off('pagehide.removePage', '#' + id);
      $(this).remove();
    });
  },
  this.updateElement = function(id) {
    request = $.ajax({type:'GET', url:'/' + RubyApp.getData('locale', 'en') + '/elements/' + id + '.html'});
    request
      .success( function(content) {
        $('#' + id).replaceWith(content);
        $('#' + id).parent().trigger('create');
      } );
  },
  this.createTrigger = function(id, interval) {
    RubyApp.destroyTrigger(id);
    $('#' + id)[0]._trigger = window.setInterval( function() {
      RubyApp.queueEvent({_class:'RubyApp::Element::TriggeredEvent', source:id});
    }, interval );
  },
  this.destroyTrigger = function(id) {
    if ($('#' + id)[0]._trigger != undefined) {
      window.clearInterval($('#' + id)[0]._trigger);
      $('#' + id)[0]._trigger = undefined;
    }
  },
  this.refreshBrowser = function() {
    $(window).clearQueue();
    location.assign(location.href);
  },
  this.confirmRefreshBrowser = function(message) {
    if (confirm(message))
      RubyApp.refreshBrowser();
  },
  this.go = function(url) {
    location.assign(url);
  },
  this.addClass = function(selector, _class) {
    $(selector).addClass(_class);
  },
  this.removeClass = function(selector, _class) {
    $(selector).removeClass(_class);
  },
  this.updateText = function(selector, value) {
    $(selector).text(value);
  },
  this.updateValue = function(selector, value) {
    $(selector).val(value);
  },
  this.updateValueFor = function(selector, value) {
    var _for = $(selector).attr('for');
    RubyApp.updateValue('#' + _for, value);
    RubyApp.change('#' + _for, value);
  },
  this.setCookie = function(name, value, expires) {
    document.cookie = name + '=' + value + '; expires=' + expires.toUTCString();
  },
  this.tap = function(selector) {
    $(selector).tap();
  },
  this.change = function(selector) {
    $(selector).change();
  },
  this.assertExists = function(selector) {
    RubyApp.assert('selector=' + selector, $(selector).length > 0);
  },
  this.assertExistsFor = function(selector) {
    var _for = $(selector).attr('for');
    RubyApp.assert('selector=' + selector + ', for=' + _for, $('#' + _for).length > 0);
  },
  this.assertExistsValueFor = function(selector, value) {
    var _for = $(selector).attr('for');
    var _value = $('#' + _for).val();
    RubyApp.assert('selector=' + selector + ', for=' + _for + ', value=' + value, _value == value);
  },
  this.assert = function(name, value) {
    RubyApp.queueEvent({_class:'RubyApp::Element::AssertedEvent', source:$('html').attr('id'), name:name, value:value});
  },
  this.getData = function(name, _default) {
    var value = $('meta[name="' + name + '"]').attr('content');
    return value == undefined ? _default : value;
  },
  this.log = function(message) {
    console.log(message);
  }
};

$(window).load(function() {
  RubyApp.queueEvent({_class:'RubyApp::Elements::Mobile::Document::LoadedEvent', source:$('html').attr('id')});
});
// /Users/frank.ficnar/Dropbox/Projects/gems/ruby_app/lib/ruby_app/elements/mobile/page.js.haml
$(document).ready( function() {
  $(document).on('pageshow', 'div[data-role="page"]', function(event) {
    RubyApp.queueEvent({_class:'RubyApp::Elements::Mobile::Page::ShownEvent', source:$(this).attr('id')});
  });
  $(document).on('pagebeforehide', 'div[data-role="page"]', function(event) {
    RubyApp.queueEvent({_class:'RubyApp::Elements::Mobile::Page::BeforeHiddenEvent', source:$(this).attr('id')});
  });
  $(document).on('pagehide', 'div[data-role="page"]', function(event) {
    RubyApp.queueEvent({_class:'RubyApp::Elements::Mobile::Page::HiddenEvent', source:$(this).attr('id')});
  });
});
// /Users/frank.ficnar/Dropbox/Projects/gems/ruby_app/lib/ruby_app/elements/mobile/click.js.haml
$(document).ready( function() {
  $(document).on('tap', '.click', function(event) {
    event.preventDefault();
    RubyApp.queueEvent({_class:'RubyApp::Elements::Mobile::Click::ClickedEvent', source:$(this).attr('id')});
  });
});


// /Users/frank.ficnar/Dropbox/Projects/gems/ruby_app/lib/ruby_app/elements/mobile/dialog.js.haml
$(document).ready( function() {
  $(document).on('pageshow', 'div[data-role="dialog"]', function(event) {
    RubyApp.queueEvent({_class:'RubyApp::Elements::Mobile::Dialog::ShownEvent', source:$(this).attr('id')});
  });
  $(document).on('pagehide', 'div[data-role="dialog"]', function(event) {
    RubyApp.queueEvent({_class:'RubyApp::Elements::Mobile::Dialog::HiddenEvent', source:$(this).attr('id')});
  });
});

// /Users/frank.ficnar/Dropbox/Projects/gems/ruby_app/lib/ruby_app/elements/mobile/input.js.haml
$(document).ready( function() {
  $(document).on('change', 'input', function(event) {
    event.preventDefault();
    RubyApp.queueEvent({_class:'RubyApp::Elements::Mobile::Input::ChangedEvent', source:$(this).attr('id'), value:$(this).val()});
  });
});


// /Users/frank.ficnar/Dropbox/Projects/gems/ruby_app/lib/ruby_app/elements/mobile/inputs/multiline_input.js.haml
$(document).ready( function() {
  $(document).on('change', 'textarea', function(event) {
    event.preventDefault();
    RubyApp.queueEvent({_class:'RubyApp::Elements::Mobile::Inputs::MultilineInput::ChangedEvent', source:$(this).attr('id'), value:$(this).val()});
  });
});
// /Users/frank.ficnar/Dropbox/Projects/gems/ruby_app/lib/ruby_app/elements/mobile/inputs/toggle_input.js.haml
$(document).ready( function() {
  $(document).on('change', 'select[data-role="slider"]', function(event) {
    event.preventDefault();
    RubyApp.queueEvent({_class:'RubyApp::Elements::Mobile::Inputs::ToggleInput::ChangedEvent', source:$(this).attr('id'), value:$(this).val()});
  });
});


// /Users/frank.ficnar/Dropbox/Projects/gems/ruby_app/lib/ruby_app/elements/mobile/list.js.haml
$(document).ready( function() {
  $(document).on('tap', 'ul.list > li.item a.item', function(event) {
    event.preventDefault();
    RubyApp.queueEvent({_class:'RubyApp::Elements::Mobile::List::ClickedEvent', source:$(this).parents('ul.list').attr('id'), index:$(this).attr('index')});
  });
});
