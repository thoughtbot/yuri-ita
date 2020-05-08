module Yuriita
  class DynamicFilter
    attr_reader :qualifier

    def initialize(qualifier:, &block)
      @qualifier = qualifier
      @block = block
    end

    def apply(relation, input)
      block.call(relation, input)
    end

    private

    attr_reader :block
  end
end
