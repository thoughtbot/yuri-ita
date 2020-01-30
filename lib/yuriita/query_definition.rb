module Yuriita
  class QueryDefinition
    attr_reader :filters

    def initialize(filters:)
      @filters = filters
    end
  end
end
