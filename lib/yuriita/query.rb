module Yuriita
  class Query
    include Enumerable

    attr_reader :keywords, :inputs

    def initialize(keywords: [], inputs: [])
      @keywords = keywords
      @inputs = inputs
    end

    def each(&block)
      block or return enum_for(__method__) { size }
      inputs.each(&block)
      self
    end

    def each_element(&block)
      block or return enum_for(__method__) { size + keywords.size }
      elements = inputs + keywords
      elements.each(&block)
      self
    end

    def add_input(input)
      inputs << input
      self
    end
    alias << add_input

    def delete_if
      block_given? or return enum_for(__method__) { size }
      select { |input| yield input }.each { |input| inputs.delete(input) }
      self
    end

    def size
      inputs.size
    end
    alias length size

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
