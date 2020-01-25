module Yuriita
  class Fragment
    attr_reader :keywords, :expressions

    def initialize(keywords: [], expressions: [])
      @keywords = keywords
      @expressions = expressions
    end

    def merge(other)
      Fragment.new(
        keywords: keywords + other.keywords,
        expressions: expressions + other.expressions,
      )
    end
  end
end
