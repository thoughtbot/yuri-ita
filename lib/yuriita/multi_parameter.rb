module Yuriita
  class MultiParameter
    def initialize(query:, formatter:)
      @query = query
      @formatter = formatter
    end

    def select(input)
      format(query << input)
    end

    def deselect(input)
      format(query.delete(input))
    end

    private

    attr_reader :option, :query, :formatter

    def format(query)
      formatter.format(query)
    end
  end
end
