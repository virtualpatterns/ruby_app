require 'rubygems'
require 'bundler/setup'

require 'sass/plugin'

Sass::Plugin.options[:load_paths] = [File.expand_path(File.join(File.dirname(__FILE__), %w[mobile]))]

require 'ruby_app/elements/base/base_page'
require 'ruby_app/elements/calendars/month'
require 'ruby_app/elements/dialog'
require 'ruby_app/elements/dialogs/blank_dialog'
require 'ruby_app/elements/dialogs/close_dialog'
require 'ruby_app/elements/dialogs/yes_no_dialog'
require 'ruby_app/elements/input'
require 'ruby_app/elements/inputs/toggle_input'
require 'ruby_app/elements/list'
require 'ruby_app/elements/lists/select'
require 'ruby_app/elements/markdown'
require 'ruby_app/elements/navigation/base/base_breadcrumbs'
require 'ruby_app/elements/page'
require 'ruby_app/elements/pages/authentication/open_id/authentication_page'
require 'ruby_app/elements/pages/base/base_blank_page'
require 'ruby_app/elements/pages/blank_page'

RubyApp::Elements::Base::BasePage.template_path(:html, File.join(File.dirname(__FILE__), %w[mobile base]))
RubyApp::Elements::Calendars::Month.template_path(:css, File.join(File.dirname(__FILE__), %w[mobile calendars]))
RubyApp::Elements::Dialog.template_path(:css, File.join(File.dirname(__FILE__), %w[mobile]))
RubyApp::Elements::Dialogs::BlankDialog.template_path(:css, File.join(File.dirname(__FILE__), %w[mobile dialogs]))
RubyApp::Elements::Dialogs::CloseDialog.template_path(:css, File.join(File.dirname(__FILE__), %w[mobile dialogs]))
RubyApp::Elements::Dialogs::YesNoDialog.template_path(:css, File.join(File.dirname(__FILE__), %w[mobile dialogs]))
RubyApp::Elements::Input.template_path(:css, File.join(File.dirname(__FILE__), %w[mobile]))
RubyApp::Elements::Inputs::ToggleInput.template_path(:css, File.join(File.dirname(__FILE__), %w[mobile inputs]))
RubyApp::Elements::List.template_path(:css, File.join(File.dirname(__FILE__), %w[mobile]))
RubyApp::Elements::Lists::Select.template_path(:css, File.join(File.dirname(__FILE__), %w[mobile lists]))
RubyApp::Elements::Markdown.template_path(:css, File.join(File.dirname(__FILE__), %w[mobile]))
RubyApp::Elements::Navigation::Base::BaseBreadcrumbs.template_path(:html, File.join(File.dirname(__FILE__), %w[mobile navigation base]))
RubyApp::Elements::Page.template_path(:css, File.join(File.dirname(__FILE__), %w[mobile]))
RubyApp::Elements::Pages::Authentication::OpenId::AuthenticationPage.template_path(:css, File.join(File.dirname(__FILE__), %w[mobile pages authentication open_id]))
RubyApp::Elements::Pages::Base::BaseBlankPage.template_path(:html, File.join(File.dirname(__FILE__), %w[mobile pages base]))
RubyApp::Elements::Pages::Base::BaseBlankPage.template_path(:css, File.join(File.dirname(__FILE__), %w[mobile pages base]))
RubyApp::Elements::Pages::BlankPage.template_path(:css, File.join(File.dirname(__FILE__), %w[mobile pages]))
