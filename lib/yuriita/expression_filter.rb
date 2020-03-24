module Yuriita
  class ExpressionFilter
    def initialize(matcher:, &block)
      @matcher = matcher
      @block = block
    end

    def matches?(inputs)
      inputs.any? do |input|
        matches_input?(input)
      end
    end

    def apply(relation)
      block.call(relation)
    end

    def build_input
      matcher.build_input
    end

    private

    attr_reader :matcher, :block

    def matches_input?(input)
      matcher.match?(input)
    end
  end
end
