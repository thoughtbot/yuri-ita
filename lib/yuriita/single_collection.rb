module Yuriita
  class SingleCollection
    def initialize(definition:, query:, formatter: nil)
      @definition = definition
      @query = query
      @formatter = formatter
    end

    def apply(relation)
      if selected_option.present?
        selected_option.filter.apply(relation)
      else
        relation
      end
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
      if selected_option.present?
        selected_option == option
      else
        false
      end
    end

    def params(option)
      formatter.format build_query(option)
    end

    def build_query(option)
      if selected?(option)
        option_query = query.dup
        option_query.delete_if do |input|
          options.any? { |option| option.match?([input]) }
        end
      else
        option_query = query.dup
        option_query.delete_if do |input|
          options.any? { |option| option.match?([input]) }
        end
        option_query << option.build_input
      end
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
      options.detect { |option| option.match?([input]) }
    end

    def matching_inputs
      inputs.select do |input|
        options.any? { |option| option.match?([input]) }
      end
    end

    def inputs
      query.inputs
    end

    def options
      definition.options
    end
  end
end
