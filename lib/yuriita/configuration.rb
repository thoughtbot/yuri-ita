module Yuriita
  class Configuration
    attr_reader :definitions, :scopes

    def initialize(definitions: {}, scopes: {})
      @definitions = definitions
      @scopes = scopes
    end

    def find_definition(key)
      definitions.fetch(key)
    end
  end
end
