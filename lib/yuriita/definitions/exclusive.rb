module Yuriita
  module Definitions
    class Exclusive
      attr_reader :options, :default

      def initialize(options:, default:)
        @options = options
        @default = default
      end

      def apply(query:)
        selector = Selects::Exclusive.new(
          options: options,
          default: default,
          query: query,
        )

        filters = [selector.filter]
        Clauses::Filter.new(filters: filters, combination: combination)
      end

      def view_options(query:, param_key:)
        ExclusiveCollection.new(
          definition: self,
          query: query,
          formatter: Yuriita::QueryFormatter.new(param_key: param_key),
        ).view_options
      end

      def combination
        AndCombination
      end
    end
  end
end
