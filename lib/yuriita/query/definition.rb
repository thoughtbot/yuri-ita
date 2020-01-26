module Yuriita
  class Query
    class Definition
      def initialize(filters:)
        @filters = filters
      end

      # keywords will need to be passed in here too
      # sort probably gets passed in here too when we implement it
      def extract(expressions)
        expressions.flat_map do |expression|
          filters.map do |filter|
            filter.apply(expression)
          end
        end.uniq
      end

      private

      attr_reader :filters
    end
  end
end
