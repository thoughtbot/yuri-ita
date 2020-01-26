require "spec_helper"
require "yuriita/query/definition"
require "yuriita/filters/static"
require "yuriita/filters/value"
require "yuriita/expression"

RSpec.describe Yuriita::Query::Definition do
  describe "#extract" do
    it "applies each filter to each expression" do
      conditions = {}
      active_filter = Yuriita::Filters::Static.new(
        expressions: [["is", "active"]],
        conditions: { active: true },
      )
      state_filter = Yuriita::Filters::Static.new(
        expressions: [["state", "open"], ["is", "open"]],
        conditions: { state: :open },
      )
      definition = described_class.new(filters: [active_filter, state_filter])
      expressions = [
        Yuriita::Expression.new(qualifier: "is", term: "active"),
        Yuriita::Expression.new(qualifier: "state", term: "open"),
        Yuriita::Expression.new(qualifier: "is", term: "open"),
        Yuriita::Expression.new(qualifier: "author", term: "eebs"),
        Yuriita::Expression.new(qualifier: "is", term: "complete"),
      ]

      result = definition.extract(expressions)

      expect(result).to contain_exactly(
        Yuriita::Clauses::Where.new(active: true),
        Yuriita::Clauses::Where.new(state: :open),
        Yuriita::Clauses::Noop.new,
      )
    end

    it "applies static filters" do
      state_filter = Yuriita::Filters::Static.new(
        expressions: [["is", "open"]],
        conditions: { state: :open },
      )
      definition = described_class.new(filters: [state_filter])
      expression = Yuriita::Expression.new(qualifier: "is", term: "open")

      result = definition.extract([expression])

      expect(result).to contain_exactly(
        Yuriita::Clauses::Where.new(state: :open),
      )
    end

    it "applies value filters" do
      author_filter = Yuriita::Filters::Value.new(
        qualifiers: ["author"],
        column: :author,
      )
      definition = described_class.new(filters: [author_filter])
      expression = Yuriita::Expression.new(qualifier: "author", term: "eebs")

      result = definition.extract([expression])

      expect(result).to contain_exactly(
        Yuriita::Clauses::Where.new(author: "eebs"),
      )
    end
  end
end
