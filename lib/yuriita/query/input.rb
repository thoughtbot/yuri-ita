module Yuriita
  class Query
    class Input
      attr_reader :qualifier, :term

      def initialize(qualifier:, term:)
        @qualifier = qualifier
        @term = term
      end

      def ==(other)
        other.is_a?(self.class) &&
          other.qualifier == qualifier &&
          other.term == term
      end
      alias_method :eql?, :==

      def to_s
        "#{qualifier}:#{term}"
      end
    end
  end
end
