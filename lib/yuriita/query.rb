module Yuriita
  class Query
    include Enumerable

    attr_reader :inputs

    def initialize(inputs: [])
      @inputs = inputs
    end

    def ==(other)
      other.is_a?(self.class) && other.inputs == inputs
    end

    def keywords
      inputs.select { |input| input.is_a?(Yuriita::Inputs::Keyword) }
    end

    def each(&block)
      block or return enum_for(__method__) { size }
      inputs.each(&block)
      self
    end

    def add_input(input)
      inputs << input
      self
    end
    alias_method :<<, :add_input

    def delete(input)
      inputs.delete(input)
      self
    end

    def delete_if
      block_given? or return enum_for(__method__) { size }
      select { |input| yield input }.each { |input| inputs.delete(input) }
      self
    end

    def size
      inputs.size
    end
    alias_method :length, :size

    def initialize_dup(original)
      super
      @inputs = original.instance_variable_get(:@inputs).dup
    end

    def initialize_clone(original)
      super
      @inputs = original.instance_variable_get(:@inputs).clone
    end
  end
end
