module Yuriita
  class Scope
    attr_reader :options, :combination

    def initialize(options:, combination:)
      @options = options
      @combination = combination
    end

    def apply(query:)
      selector = AllOrExplicitSelect.new(options: options, query: query)

      Clauses::Search.new(
        filters: selector.filters,
        keywords: query.keywords,
        combination: combination,
      )
    end
  end
end
