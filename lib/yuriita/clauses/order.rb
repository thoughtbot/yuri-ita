module Yuriita
  module Clauses
    class Order
      attr_reader :conditions

      def initialize(conditions)
        @conditions = conditions
      end

      def call(relation)
        relation.order(conditions)
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
