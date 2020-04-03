module Yuriita
  class Query
    class Fragment
      attr_reader :inputs

      def initialize(inputs: [])
        @inputs = inputs
      end

      def merge(other)
        Fragment.new(
          inputs: inputs + other.inputs,
        )
      end
    end
  end
end
