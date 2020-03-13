module Yuriita
  class Query
    attr_reader :keywords, :expression_inputs, :scope_inputs

    def initialize(keywords: [], expression_inputs: [], scope_inputs: [])
      @keywords = keywords
      @expression_inputs = expression_inputs
      @scope_inputs = scope_inputs
    end
  end
end
