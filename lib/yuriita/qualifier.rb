module Yuriita
  class Qualifier
    attr_reader :key, :negated

    def initialize(key:, negated: false)
      @key = key
      @negated = negated
    end

    def negated?
      negated
    end
  end
end
