module Yuriita
  class AllOrExplicitSelect
    def initialize(options:, query:)
      @options = options
      @query = query
    end

    def filters
      active_options.map(&:filter)
    end

    private

    attr_reader :options, :query

    def active_options
      explicit_options.presence || options
    end

    def explicit_options
      options.select do |option|
        query.include?(option.input)
      end
    end
  end
end
