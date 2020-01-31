module Yuriita
  class Fragment
    attr_reader :keywords, :expressions, :scopes

    def initialize(keywords: [], expressions: [], scopes: [])
      @keywords = keywords
      @expressions = expressions
      @scopes = scopes
    end

    def merge(other)
      Fragment.new(
        keywords: keywords + other.keywords,
        expressions: expressions + other.expressions,
        scopes: scopes + other.scopes,
      )
    end
  end
end
