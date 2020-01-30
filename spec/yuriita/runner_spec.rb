require "spec_helper"
require "yuriita/runner"
require "yuriita/query/definition"
require "yuriita/filters/fixed_condition"

RSpec.describe Yuriita::Runner do
  describe "#run" do
    it "parses and executes the query" do
      relation = spy(:relation)
      definition = Yuriita::Query::Definition.new(
        filters: [
          Yuriita::Filters::FixedCondition.new(
            expressions: [["is", "active"]],
            conditions: { active: true },
          ),
        ],
      )

      runner = described_class.new(relation: relation, definition: definition)
      result = runner.run("is:active")

      expect(result).to be_successful
      expect(relation).to have_received(:where).with(active: true)
    end

    it "returns an error result for invalid queries" do
      relation = spy(:relation)
      definition = Yuriita::Query::Definition.new(
        filters: [
          Yuriita::Filters::FixedCondition.new(
            expressions: [["is", "active"]],
            conditions: { active: true },
          ),
        ],
      )

      runner = described_class.new(relation: relation, definition: definition)
      result = runner.run("invalid:")

      expect(result).not_to be_successful
    end
  end
end
