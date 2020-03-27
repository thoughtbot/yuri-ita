module Yuriita
  class SingleDefinition
    attr_reader :options

    def initialize(options:)
      @options = options
    end

    def apply(query:)
      SingleCollection.new(
        definition: self,
        query: query,
      )
    end

    def view_options(query:, param_key:)
      SingleCollection.new(
        definition: self,
        query: query,
        formatter: Yuriita::QueryFormatter.new(param_key: param_key),
      ).view_options
    end
  end
end
