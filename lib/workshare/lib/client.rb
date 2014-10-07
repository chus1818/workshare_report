module Workshare
  module Client
    include ClassConfigurable
    include HTTParty
    
    after_config { base_uri config.api_host }

    def self.login(user_credentials)
      form_data = {
        user_session: user_credentials,
        device: { app_uid: config.api_key }
      }

      response = post '/api/open-v1.0/user_sessions.json', body: form_data
      Presenters::LoginResponse.new response
    end

    def self.files(access_credentials)
      cookies = access_cookies(access_credentials).to_h
      Presenters::Files.new get('/api/open-v1.0/files.json', cookies: cookies)
    end

  private

    def self.access_cookies(access_credentials)
      CookieHash.new.tap do |cookies|
        access_credentials.split(",").each { |cookie| cookies.add_cookies(cookie) }
      end
    end
  end
end

require_relative './client_related/presenters'