module Workshare
  module Client
    module Presenters
      class LoginResponse
        attr_reader :raw

        def initialize(raw)
          @raw = clean(raw).symbolize_keys
        end

        def has_error_code?
          raw[:error_code].present?
        end

      private

        # There's a bug in the API: for wrong credentials it
        # returns the errors hash inside an array of only one
        # element.
        def clean(raw)
          [raw].flatten[0]
        end
      end
    end
  end
end