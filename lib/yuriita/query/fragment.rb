module Yuriita
  class Query
    class Fragment
      attr_reader :keywords, :inputs

      def initialize(keywords: [], inputs: [])
        @keywords = keywords
        @inputs = inputs
      end

      def merge(other)
        Fragment.new(
          keywords: keywords + other.keywords,
          inputs: inputs + other.inputs,
        )
      end
    end
  end
end
