module Yuriita
  module Definitions
    class Exclusive
      attr_reader :options, :default

      def initialize(options:, default:)
        @options = options
        @default = default
      end

      def apply(query:)
        filter = selected_filter(query)

        Clauses::Filter.new(filters: [filter], combination:)
      end

      private

      def combination
        AndCombination
      end

      def selected_filter(query)
        Selects::Exclusive.new(
          options:,
          default:,
          query:
        ).filter
      end
    end
  end
end
