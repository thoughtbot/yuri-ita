require "yuriita/expression"

module Yuriita
  class NegatedExpression < Expression
    def negated?
      true
    end
  end
end
