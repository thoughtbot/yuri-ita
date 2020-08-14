module Yuriita
  module Definitions
    class Single
      attr_reader :options

      def initialize(options:)
        @options = options
      end

      def apply(query:)
        filter = selected_filter(query)

        if filter.present?
          Clauses::Filter.new(filters: [filter], combination: combination)
        else
          Clauses::Identity.new
        end
      end

      private

      def combination
        AndCombination
      end

      def selected_filter(query)
        Selects::Single.new(options: options, query: query).filter
      end
    end
  end
end
