module Yuriita
  module Clauses
    class Noop
      def call(relation)
        relation
      end

      def ==(other)
        other.is_a?(self.class)
      end
      alias_method :eql?, :==

      def hash
        nil.hash
      end
    end
  end
end
