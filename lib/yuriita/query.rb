module Yuriita
  class Query
    attr_reader :keywords, :expression_inputs, :scope_inputs, :sort_inputs

    def initialize(keywords: [], expression_inputs: [], scope_inputs: [], sort_inputs: [])
      @keywords = keywords
      @expression_inputs = expression_inputs
      @scope_inputs = scope_inputs
      @sort_inputs = sort_inputs
    end
  end
end
