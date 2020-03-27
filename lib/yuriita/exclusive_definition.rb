module Yuriita
  class ExclusiveDefinition
    attr_reader :options, :default

    def initialize(options:, default:)
      @options = options
      @default = default
    end

    def apply(query:)
      ExclusiveCollection.new(
        definition: self,
        query: query,
      )
    end

    def view_options(query:, param_key:)
      ExclusiveCollection.new(
        definition: self,
        query: query,
        formatter: Yuriita::QueryFormatter.new(param_key: param_key),
      ).view_options
    end
  end
end
