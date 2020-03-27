module Yuriita
  class MultipleCollection
    def initialize(definition:, query:, formatter: nil)
      @definition = definition
      @query = query
      @formatter = formatter
    end

    def apply(relation)
      return relation if active_filters.empty?

      relations = active_filters.map { |filter| filter.apply(relation) }

      definition.combination.new(
        base_relation: relation,
        relations: relations,
      ).combine
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
        selected: selected?(option),
        params: params(option),
      )
    end

    def selected?(option)
      selected_options.include?(option)
    end

    def params(option)
      formatter.format build_query(option)
    end

    def build_query(option)
      if selected?(option)
        option_query = query.dup
        option_query.delete_if do |input|
          option.match?([input])
        end
      else
        option_query = query.dup
        option_query << option.build_input
      end
    end

    def active_filters
      selected_options.map(&:filter)
    end

    def selected_options
      options.select { |option| option.match?(inputs) }
    end

    def inputs
      query.inputs
    end

    def options
      definition.options
    end
  end
end
