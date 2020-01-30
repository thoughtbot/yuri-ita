require "spec_helper"
require "yuriita/assembler"
require "yuriita/query_definition"
require "yuriita/filters/fixed_condition"
require "yuriita/filters/value_condition"
require "yuriita/expression"

RSpec.describe Yuriita::Assembler do
  describe "#extract" do
    it "applies each filter to each expression" do
      conditions = {}
      active_filter = Yuriita::Filters::FixedCondition.new(
        expressions: [["is", "active"]],
        conditions: { active: true },
      )
      state_filter = Yuriita::Filters::FixedCondition.new(
        expressions: [["state", "open"], ["is", "open"]],
        conditions: { state: :open },
      )
      definition = build_definition([active_filter, state_filter])
      expressions = [
        Yuriita::Expression.new(qualifier: "is", term: "active"),
        Yuriita::Expression.new(qualifier: "state", term: "open"),
        Yuriita::Expression.new(qualifier: "is", term: "open"),
        Yuriita::Expression.new(qualifier: "author", term: "eebs"),
        Yuriita::Expression.new(qualifier: "is", term: "complete"),
      ]

      result = described_class.new(definition).build(expressions)

      expect(result).to contain_exactly(
        Yuriita::Clauses::Where.new(active: true),
        Yuriita::Clauses::Where.new(state: :open),
        Yuriita::Clauses::Noop.new,
      )
    end

    it "applies fixed condition filters" do
      state_filter = Yuriita::Filters::FixedCondition.new(
        expressions: [["is", "open"]],
        conditions: { state: :open },
      )
      definition = build_definition([state_filter])
      expression = Yuriita::Expression.new(qualifier: "is", term: "open")

      result = described_class.new(definition).build([expression])

      expect(result).to contain_exactly(
        Yuriita::Clauses::Where.new(state: :open),
      )
    end

    it "applies value condition filters" do
      author_filter = Yuriita::Filters::ValueCondition.new(
        qualifiers: ["author"],
        column: :author,
      )
      definition = build_definition([author_filter])
      expression = Yuriita::Expression.new(qualifier: "author", term: "eebs")

      result = described_class.new(definition).build([expression])

      expect(result).to contain_exactly(
        Yuriita::Clauses::Where.new(author: "eebs"),
      )
    end
  end

  def build_definition(filters)
    Yuriita::QueryDefinition.new(filters: filters)
  end
end
