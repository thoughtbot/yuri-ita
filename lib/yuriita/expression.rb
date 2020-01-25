module Yuriita
  class Expression
    attr_reader :qualifier, :term, :negated

    def initialize(qualifier:, term:, negated: false)
      @qualifier = qualifier
      @term = term
      @negated = negated
    end

    def negated?
      negated
    end

    def ==(other)
      other.is_a?(self.class) &&
        qualifier == other.qualifier &&
        term == other.term &&
        negated? == other.negated?
    end
  end
end
