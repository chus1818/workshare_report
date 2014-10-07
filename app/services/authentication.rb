class Authentication
  attr_reader :credentials, :engine, :errors, :cookies

  def initialize(credentials, engine = Workshare::Client)
    @credentials = credentials
    @engine      = engine
    @errors      = Errors.new :unperformed_authentication
  end

  def perform
    errors.remove :unperformed_authentication    
    errors.add :wrong_credentials if login.has_error_code? 
    self
  rescue => e
    Rails.logger.error "[ERROR] Authentication Unexpected: #{e.message}\n #{e.backtrace}"
    errors.add :unexpected_error
    self
  end

  def success?
    errors.empty?
  end

  def access_cookies
    login.access_cookies if success?
  end

private

  def login
    @login ||= engine.login credentials
  end
end

require_dependency './authentication_related/errors'