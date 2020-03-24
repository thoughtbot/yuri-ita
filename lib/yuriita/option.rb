module Yuriita
  class Option
    attr_reader :name, :filter

    def initialize(name:, filter:)
      @name = name
      @filter = filter
    end

    def match?(inputs)
      filter.matches?(inputs)
    end

    def build_input
      filter.build_input
    end
  end
end
