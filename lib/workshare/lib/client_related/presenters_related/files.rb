module Workshare
  module Client
    module Presenters
      class Files
        include Enumerable

        attr_reader :raw
        delegate :each, to: :elements

        def initialize(raw)
          @raw = raw.normalize
        end

        def elements
          raw_elements
        end

        def pagination
          raw[:pagination]
        end

      private

        def raw_elements
          raw[:files]
        end
      end
    end
  end
end