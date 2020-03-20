module Yuriita
  class KeywordFilterAssembler
    def initialize(keyword_filters:, keywords:, scope_inputs:, combination: OrCombination)
      @keyword_filters = keyword_filters
      @keywords = keywords
      @scope_inputs = scope_inputs
      @combination = combination
    end

    def assemble
      if keyword_filter_clauses.any?
        [merge_keyword_filter_clauses]
      else
        []
      end
    end

    private

    attr_reader :keyword_filters, :keywords, :scope_inputs, :combination

    def merge_keyword_filter_clauses
      Clauses::Merge.new(clauses: keyword_filter_clauses, combination: combination)
    end

    def keyword_filter_clauses
      @keyword_filter_clauses ||= keyword_filters.flat_map do |keyword_filter|
        keyword_filter.apply(keywords, scope_inputs)
      end
    end
  end
end
