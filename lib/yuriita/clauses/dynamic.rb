module Yuriita
  module Clauses
    class Dynamic
      def initialize(filter:, input:)
        @filter = filter
        @input = input
      end

      def apply(relation)
        filter.apply(relation, input)
      end

      private

      attr_reader :filter, :input
    end
  end
end
