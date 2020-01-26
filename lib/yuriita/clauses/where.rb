module Yuriita
  module Clauses
    class Where
      attr_reader :conditions

      def initialize(conditions)
        @conditions = conditions
      end

      def call(relation)
        relation.where(conditions)
      end

      def ==(other)
        other.is_a?(self.class) && conditions == other.conditions
      end
      alias_method :eql?, :==

      def hash
        [self.class, conditions].hash
      end
    end
  end
end
