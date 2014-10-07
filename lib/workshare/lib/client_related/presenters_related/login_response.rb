module Workshare
  module Client
    module Presenters
      class LoginResponse
        attr_reader :body, :headers

        def initialize(response)
          @body    = clean(response).symbolize_keys
          @headers = response.headers
        end

        def access_cookies
          headers["set-cookie"]
        end

        def has_error_code?
          body[:error_code].present?
        end

      private

        # There's a bug in the API: for wrong credentials it
        # returns the errors hash inside an array of only one
        # element.
        def clean(response)
          [response].flatten[0].to_h
        end
      end
    end
  end
end