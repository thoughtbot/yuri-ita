module Yuriita
  class Configuration
    attr_reader :definitions

    def initialize(definitions)
      @definitions = definitions
    end

    def find_definition(key)
      definitions.fetch(key)
    end
  end
end
