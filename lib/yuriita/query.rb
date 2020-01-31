module Yuriita
  class Query
    attr_reader :keywords, :expressions, :scopes

    def initialize(keywords: [], expressions: [], scopes: [])
      @keywords = keywords
      @expressions = expressions
      @scopes = scopes
    end
  end
end
