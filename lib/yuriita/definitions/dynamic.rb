module Yuriita
  module Definitions
    class Dynamic
      def initialize(filter:)
        @filter = filter
      end

      def apply(query:)
        input = select_input(query)

        if input.present?
          Clauses::Dynamic.new(filter: filter, input: input)
        else
          Clauses::Identity.new
        end
      end

      private

      attr_reader :filter

      def select_input(query)
        matching_inputs(query).last
      end

      def matching_inputs(query)
        query.select do |input|
          case input
          when Inputs::Expression
            input.qualifier == filter.qualifier
          else
            false
          end
        end
      end
    end
  end
end
