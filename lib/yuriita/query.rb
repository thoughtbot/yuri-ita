module Yuriita
  class Query
    attr_reader :keywords, :expressions

    def initialize(keywords: [], expressions: [])
      @keywords = keywords
      @expressions = expressions
    end
  end
end
