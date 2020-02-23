module Yuriita
  module Matchers
    class Expression
      def initialize(qualifier:, term:)
        @qualifier = qualifier
        @term = term
      end

      def match?(expression)
        expression.qualifier == qualifier &&
          expression.term == term
      end

      private

      attr_reader :qualifier, :term
    end
  end
end
