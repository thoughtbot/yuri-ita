module Yuriita
  class ExclusiveCollection
    def initialize(definition:, query:, formatter: nil)
      @definition = definition
      @query = query
      @formatter = formatter
    end

    def apply(relation)
      active_filter.apply(relation)
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
      # We have to do this because of how we're creating the options.
      # In the definition we are creating duplicate options when we call the
      # method multiple times.
      active_option.name == option.name
    end

    def params(option)
      formatter.format build_query(option)
    end

    def build_query(option)
      if selected?(option)
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

    def active_filter
      active_option.filter
    end

    def active_option
      selected_option || default_option
    end

    def selected_option
      input = last_matching_input
      if input.present?
        option_for(input)
      end
    end

    def last_matching_input
      matching_inputs.last
    end

    def option_for(input)
      options.detect { |option| option.input == input }
    end

    def matching_inputs
      query.select do |input|
        options.any? { |option| option.input == input }
      end
    end

    def options
      definition.options
    end

    def default_option
      definition.default
    end
  end
end
