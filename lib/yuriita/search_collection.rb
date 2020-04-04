module Yuriita
  class SearchCollection
    def initialize(scope:, query:)
      @scope = scope
      @query = query
    end

    def apply(relation)
      return relation if active_filters.empty? || keywords.empty?

      relations = active_filters.map do |filter|
        filter.apply(relation, keywords)
      end

      scope.combination.new(
        base_relation: relation,
        relations: relations,
      ).combine
    end

    private

    attr_reader :scope, :query

    def active_filters
      selected_options.map(&:filter)
    end

    def selected_options
      explicit_options.presence || options
    end

    def explicit_options
      options.select do |option|
        query.include?(option.input)
      end
    end

    def options
      scope.options
    end

    def keywords
      query.keywords
    end
  end
end
