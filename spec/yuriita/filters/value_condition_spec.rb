require "spec_helper"
require "yuriita/filters/value_condition"
require "yuriita/expression"
require "yuriita/negated_expression"

RSpec.describe Yuriita::Filters::ValueCondition do
  describe "#apply" do
    it "matches any qualifier" do
      filter = described_class.new(
        qualifiers: ["author"],
        column: :author,
      )
      expression = Yuriita::Expression.new(qualifier: "author", term: "eebs")

      result = filter.apply(expression)

      expect(result).to eq Yuriita::Clauses::Where.new(author: "eebs")
    end

    it "returns a WhereNot if the expression is negative" do
      filter = described_class.new(
        qualifiers: ["author"],
        column: :author,
      )
      expression = Yuriita::NegatedExpression.new(
        qualifier: "author",
        term: "eebs",
      )

      result = filter.apply(expression)

      expect(result).to eq Yuriita::Clauses::WhereNot.new(author: "eebs")
    end

    it "returns a no-op if it does not match the expression" do
      filter = described_class.new(
        qualifiers: ["author"],
        column: :author,
      )
      expression = Yuriita::NegatedExpression.new(
        qualifier: "is",
        term: "open",
      )

      result = filter.apply(expression)

      expect(result).to eq Yuriita::Clauses::Noop.new
    end
  end
end
