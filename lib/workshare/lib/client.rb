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

      response = post('/api/open-v1.0/user_sessions.json', body: form_data)
      default_cookies.add_cookies(response.headers["set-cookie"])
      
      Presenters::LoginResponse.new response
    end

    def self.logout
      remove_cookies
    end

    def self.files
      Presenters::Files.new get('/api/open-v1.0/files.json')
    end

  private

    def self.remove_cookies
      self.default_cookies = CookieHash.new
    end
  end
end

require_relative './client_related/presenters'