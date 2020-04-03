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

    def ==(other)
      other.is_a?(self.class) && other.name == name
    end
    alias_method :eql?, :==
  end
end
