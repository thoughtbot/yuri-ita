module Yuriita
  class Query
    class Input
      attr_reader :qualifier, :term

      def initialize(qualifier:, term:)
        @qualifier = qualifier
        @term = term
      end

      def to_s
        "#{qualifier}:#{term}"
      end
    end
  end
end
