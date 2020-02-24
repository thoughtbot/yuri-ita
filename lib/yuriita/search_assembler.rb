require "yuriita/or_combination"
require "yuriita/clauses/merge"

module Yuriita
  class SearchAssembler
    def initialize(keyword_searches:, keywords:, scopes:, combination: OrCombination)
      @keyword_searches = keyword_searches
      @keywords = keywords
      @scopes = scopes
      @combination = combination
    end

    def assemble
      if search_clauses.any?
        [merge_search_clauses]
      else
        []
      end
    end

    private

    attr_reader :keyword_searches, :keywords, :scopes, :combination

    def merge_search_clauses
      Clauses::Merge.new(clauses: search_clauses, combination: combination)
    end

    def search_clauses
      @search_clauses ||= keyword_searches.flat_map do |keyword_search|
        keyword_search.apply(keywords, scopes)
      end
    end
  end
end
