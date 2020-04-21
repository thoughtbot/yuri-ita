module Yuriita
  class Configuration
    include Enumerable

    def initialize(definitions)
      @definitions = definitions
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
