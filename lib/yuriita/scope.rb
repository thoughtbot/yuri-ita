module Yuriita
  class Scope
    attr_reader :options, :combination

    def initialize(options:, combination:)
      @options = options
      @combination = combination
    end

    def apply(query:)
      SearchCollection.new(
        scope: self,
        query: query
      )
    end
  end
end
