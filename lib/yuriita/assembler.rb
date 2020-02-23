module Yuriita
  class Assembler
    def initialize(definition)
      @definition = definition
    end

    # keywords will need to be passed in here too
    # sort probably gets passed in here too when we implement it
    def build(expressions)
      filters.flat_map do |filter|
        filter.apply(expressions)
      end
    end

    private

    attr_reader :definition

    def filters
      definition.filters
    end
  end
end
