module Yuriita
  class Option
    attr_reader :name, :filter

    def initialize(name:, filter:)
      @name = name
      @filter = filter
    end

    def input
      filter.input
    end
  end
end
