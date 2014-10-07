module Workshare
  module Client
    module Presenters
      class Files
        include Enumerable

        attr_reader :raw, :body
        delegate :each, to: :elements

        def initialize(raw)
          @raw  = raw.normalize
          @body = raw.symbolize_keys
        end

        def elements
          raw_elements
        end

        def has_error_code?
          body[:error_code].present?
        end

      private

        def raw_elements
          raw[:files]
        end
      end
    end
  end
end