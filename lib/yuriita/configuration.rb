module Yuriita
  class Configuration
    include Enumerable
    EMPTY_STRING = "".freeze

    attr_reader :default_input

    def initialize(definitions, default_input: EMPTY_STRING)
      @definitions = definitions
      @default_input = default_input
    end

    def find_definition(key)
      definitions.fetch(key)
    end

    def each(&block)
      block or return enum_for(__method__) { size }
      definitions.each_value(&block)
      self
    end

    def size
      definitions.size
    end

    private

    attr_reader :definitions
  end
end
