module Yuriita
  class ExclusiveSelect
    def initialize(options:, default:, query:)
      @options = options
      @default = default
      @query = query
    end

    def filter
      active_option.filter
    end

    def selected?(option)
      active_option == option
    end

    private

    attr_reader :options, :default, :query

    def active_option
      chosen_option || default
    end

    def chosen_option
      input = last_matching_input
      if input.present?
        option_for(input)
      end
    end

    def last_matching_input
      matching_inputs.last
    end

    def matching_inputs
      query.select do |input|
        options.any? { |option| option.input == input }
      end
    end

    def option_for(input)
      options.detect { |option| option.input == input }
    end
  end
end
