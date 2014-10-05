class Authentication
  attr_reader :credentials, :engine, :errors

  def self.deauthenticate
    # Refactor that
    Workshare::Client.logout
  end

  def initialize(credentials, engine = Workshare::Client)
    @credentials = credentials
    @engine      = engine
    @errors      = Errors.new :unperformed_authentication
  end

  def perform
    errors.remove :unperformed_authentication
    errors.add :wrong_credentials if engine.login(credentials).has_error_code? 
    self
  rescue => e
    Rails.logger.error "[ERROR] Authentication Unexpected: #{e.message}\n #{e.backtrace}"
    errors.add :unexpected_error
    self
  end

  def success?
    errors.empty?
  end
end

require_dependency './authentication_related/errors'