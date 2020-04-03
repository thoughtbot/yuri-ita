module Yuriita
  class ExclusiveCollection
    def initialize(definition:, query:, formatter: nil)
      @definition = definition
      @query = query
      @formatter = formatter
    end

    def apply(relation)
      selector.filter.apply(relation)
    end

    def view_options
      return enum_for(:view_options) unless block_given?

      options.each do |option|
        yield view_option(option)
      end
    end

    private

    attr_reader :definition, :query, :formatter

    def view_option(option)
      ViewOption.new(
        name: option.name,
        selected: selector.selected?(option),
        params: params(option),
      )
    end

    def params(option)
      formatter.format build_query(option)
    end

    def build_query(option)
      if selector.selected?(option)
        option_query = query.dup
        matching_inputs.each do |input|
          option_query.delete(input)
        end
        option_query
      else
        option_query = query.dup
        matching_inputs.each do |input|
          option_query.delete(input)
        end
        option_query << option.input
      end
    end

    def matching_inputs
      query.select do |input|
        options.any? { |option| option.input == input }
      end
    end

    def options
      definition.options
    end

    def selector
      ExclusiveSelect.new(
        options: options,
        default: definition.default,
        query: query,
      )
    end
  end
end
