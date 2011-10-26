require File.join(File.dirname(__FILE__), %w[.. .. application])
require File.join(File.dirname(__FILE__), %w[.. .. session])

shared_context '_APPLICATION_UPCODE_::Application' do

  before(:all) do
    options = {:application_class => _APPLICATION_UPCODE_::Application,
               :session_class => _APPLICATION_UPCODE_::Session,
               :log_path => File.join(File.dirname(__FILE__), %w[.. .. log application.log]),
               :configuration_paths => File.join(File.dirname(__FILE__), %w[.. .. config.yml])}
    _APPLICATION_UPCODE_::Application.create(options)
  end

  after(:all) do
    Pike::Application.destroy
  end

end
