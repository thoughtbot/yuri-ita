module Yuriita
  class MultipleCollection
    def initialize(definition:, query:, param_key: nil)
      @definition = definition
      @query = query
      @param_key = param_key
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

    attr_reader :definition, :query, :param_key

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
      format inputs_for(option)
    end

    def inputs_for(option)
      if selected?(option)
        inputs.reject { |input| option.match?([input]) }
      else
        inputs + [option.build_input]
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

    def format(inputs)
      value = inputs.map(&:to_s).join(" ") + " " + joined_keywords
      { param_key => value.strip }
    end

    def joined_keywords
      query.keywords.join(" ")
    end
  end
end
