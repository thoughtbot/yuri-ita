module Yuriita
  class SearchCollection
    def initialize(scope:, query:)
      @scope = scope
      @query = query
    end

    def apply(relation)
      selector = AllOrExplicitSelect.new(options: options, query: query)
      return relation if selector.empty?

      relations = selector.filters.map { |filter| filter.apply(relation, keywords) }

      scope.combination.new(
        base_relation: relation,
        relations: relations,
      ).combine
    end

    private

    attr_reader :scope, :query

    def options
      scope.options
    end

    def keywords
      query.keywords
    end
  end
end
