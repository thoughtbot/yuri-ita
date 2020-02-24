module Yuriita
  module Matchers
    class Expression
      def initialize(qualifier:, term:)
        @qualifier = qualifier
        @term = term
      end

      def match?(input)
        input.qualifier == qualifier &&
          input.term == term
      end

      private

      attr_reader :qualifier, :term
    end
  end
end
