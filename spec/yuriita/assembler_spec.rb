require "spec_helper"
require "yuriita/assembler"
require "yuriita/query_definition"
require "yuriita/query/input"
require "yuriita/filters/fixed_condition"
require "yuriita/filters/value_condition"
require "yuriita/definition/expression"

RSpec.describe Yuriita::Assembler do
  describe "#build" do
    it "applies each filter to each expression" do
      conditions = {}
      active_filter = Yuriita::Filters::FixedCondition.new(
        expressions: [expression("is:active")],
        conditions: { active: true },
      )
      state_filter = Yuriita::Filters::FixedCondition.new(
        expressions: [expression("state:open"), expression("is:open")],
        conditions: { state: :open },
      )
      definition = build_definition([active_filter, state_filter])
      expressions = [
        Yuriita::Query::Input.new(qualifier: "is", term: "active"),
        Yuriita::Query::Input.new(qualifier: "state", term: "open"),
        Yuriita::Query::Input.new(qualifier: "is", term: "open"),
        Yuriita::Query::Input.new(qualifier: "author", term: "eebs"),
        Yuriita::Query::Input.new(qualifier: "is", term: "complete"),
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
        expressions: [expression("is:open")],
        conditions: { state: :open },
      )
      definition = build_definition([state_filter])
      expression = Yuriita::Query::Input.new(qualifier: "is", term: "open")

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
      expression = Yuriita::Query::Input.new(qualifier: "author", term: "eebs")

      result = described_class.new(definition).build([expression])

      expect(result).to contain_exactly(
        Yuriita::Clauses::Where.new(author: "eebs"),
      )
    end
  end

  def build_definition(filters)
    Yuriita::QueryDefinition.new(filters: filters)
  end

  def expression(string)
    Yuriita::Definition::Expression.new(string)
  end
end
