module Yuriita
  class Query
    class Input
      attr_reader :qualifier, :term

      def initialize(qualifier:, term:, negated: false)
        @qualifier = qualifier
        @term = term
        @negated = negated
      end

      def negated?
        negated
      end

      private

      attr_reader :negated
    end
  end
end
