require "spec_helper"

require "yuriita/filters/fixed_condition"
require "yuriita/expression"
require "yuriita/negated_expression"

RSpec.describe Yuriita::Filters::FixedCondition do
  describe "#apply" do
    it "matches on qualifier and term when it has exactly one" do
      conditions = double(:conditions)
      filter = described_class.new(
        expressions: [["is", "active"]],
        conditions: conditions,
      )
      expression = Yuriita::Expression.new(qualifier: "is", term: "active")

      result = filter.apply(expression)

      expect(result).to eq Yuriita::Clauses::Where.new(conditions)
    end

    it "matches either qualifier and term when it has two" do
      conditions = double(:conditions)
      filter = described_class.new(
        expressions: [["is", "active"], ["author", "eebs"]],
        conditions: conditions,
      )
      expression = Yuriita::Expression.new(qualifier: "author", term: "eebs")

      result = filter.apply(expression)

      expect(result).to eq Yuriita::Clauses::Where.new(conditions)
    end

    it "returns a WhereNot if the expression is negative" do
      conditions = double(:conditions)
      filter = described_class.new(
        expressions: [["is", "active"], ["author", "eebs"]],
        conditions: conditions,
      )
      expression = Yuriita::NegatedExpression.new(
        qualifier: "author",
        term: "eebs",
      )

      result = filter.apply(expression)

      expect(result).to eq Yuriita::Clauses::WhereNot.new(conditions)
    end

    it "returns a no-op if it does not match the expression" do
      filter = described_class.new(
        expressions: [["is", "active"]],
        conditions: {},
      )
      expression = Yuriita::Expression.new(qualifier: "is", term: "inactive")

      result = filter.apply(expression)

      expect(result).to eq Yuriita::Clauses::Noop.new
    end
  end
end
