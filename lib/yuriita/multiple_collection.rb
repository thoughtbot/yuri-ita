module Yuriita
  class MultipleCollection
    def initialize(definition:, query:, formatter: nil)
      @definition = definition
      @query = query
      @formatter = formatter
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
        option: option,
        selector: Selects::Multiple.new(options: options, query: query),
        parameters: MultiParameter.new(query: query.dup, formatter: formatter),
      )
    end

    def options
      definition.options
    end
  end
end
