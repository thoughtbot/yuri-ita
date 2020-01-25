module Yuriita
  class Expression
    attr_reader :qualifier, :term

    def initialize(qualifier:, term:)
      @qualifier = qualifier
      @term = term
    end

    def negated?
      false
    end

    def ==(other)
      self.class == other.class &&
        qualifier == other.qualifier &&
        term == other.term
    end
  end
end
