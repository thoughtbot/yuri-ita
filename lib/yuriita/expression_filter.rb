module Yuriita
  class ExpressionFilter
    attr_reader :input

    def initialize(input:, &block)
      @input = input
      @block = block
    end

    def apply(relation)
      block.call(relation)
    end

    private

    attr_reader :block
  end
end
