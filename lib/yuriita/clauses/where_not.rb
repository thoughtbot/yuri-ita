module Yuriita
  module Clauses
    class WhereNot
      attr_reader :conditions

      def initialize(conditions)
        @conditions = conditions
      end

      def call(relation)
        relation.where.not(conditions)
      end

      def ==(other)
        other.is_a?(self.class) && conditions == other.conditions
      end
    end
  end
end
