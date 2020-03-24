module Yuriita
  class SearchClause
    def initialize(filters:, keywords:, combination:)
      @filters = filters
      @keywords = keywords
      @combination = combination
    end

    def apply(relation)
      return relation if filters.empty? || keywords.empty?

      relations = filters.map { |filter| filter.apply(relation, keywords) }

      combination.new(
        base_relation: relation,
        relations: relations,
      ).combine
    end

    private

    attr_reader :filters, :keywords, :combination
  end
end
