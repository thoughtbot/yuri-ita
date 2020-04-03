module Yuriita
  class Assembler
    attr_reader :configuration

    def initialize(configuration)
      @configuration = configuration
    end

    def build(query)
      configuration.definitions.each_value.map do |definition|
        definition.apply(query: query)
      end
    end
  end
end
