module Yuriita
  class SingleParameter
    def initialize(options:, query:, formatter:)
      @options = options
      @query = query
      @formatter = formatter
    end

    def select(input)
      matching_inputs.each do |input|
        query.delete(input)
      end
      format(query << input)
    end

    def deselect(input)
      matching_inputs.each do |input|
        query.delete(input)
      end
      format(query)
    end

    private

    attr_reader :options, :query, :formatter

    def format(query)
      formatter.format(query)
    end

    def matching_inputs
      query.select do |input|
        options.any? { |option| option.input == input }
      end
    end
  end
end
