require "spec_helper"

require "yuriita/filters/fixed_condition"
require "yuriita/query/input"
require "yuriita/definition/expression"

RSpec.describe Yuriita::Filters::FixedCondition do
  describe "#apply" do
    it "matches on qualifier and term when it has exactly one" do
      conditions = double(:conditions)
      filter = described_class.new(
        expressions: [expression("is:active")],
        conditions: conditions,
      )
      input = Yuriita::Query::Input.new(qualifier: "is", term: "active")

      result = filter.apply(input)

      expect(result).to eq Yuriita::Clauses::Where.new(conditions)
    end

    it "matches either qualifier and term when it has two" do
      conditions = double(:conditions)
      filter = described_class.new(
        expressions: [expression("is:active"), expression("author:eebs")],
        conditions: conditions,
      )
      input = Yuriita::Query::Input.new(qualifier: "author", term: "eebs")

      result = filter.apply(input)

      expect(result).to eq Yuriita::Clauses::Where.new(conditions)
    end

    it "returns a WhereNot if the input is negative" do
      conditions = double(:conditions)
      filter = described_class.new(
        expressions: [expression("is:active"), expression("author:eebs")],
        conditions: conditions,
      )
      input = Yuriita::Query::Input.new(
        qualifier: "author",
        term: "eebs",
        negated: true,
      )

      result = filter.apply(input)

      expect(result).to eq Yuriita::Clauses::WhereNot.new(conditions)
    end

    it "returns a no-op if it does not match the input" do
      filter = described_class.new(
        expressions: [expression("is:active")],
        conditions: {},
      )
      input = Yuriita::Query::Input.new(qualifier: "is", term: "inactive")

      result = filter.apply(input)

      expect(result).to eq Yuriita::Clauses::Noop.new
    end
  end

  def expression(string)
    Yuriita::Definition::Expression.new(string)
  end
end
