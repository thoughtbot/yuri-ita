module Yuriita
  module Matchers
    class Term
      def initialize(term:)
        @term = term
      end

      def match?(input)
        input.term == term
      end

      private

      attr_reader :term
    end
  end
end
