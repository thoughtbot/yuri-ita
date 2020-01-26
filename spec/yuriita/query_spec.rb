require "spec_helper"

RSpec.describe Yuriita::Query do
  describe "#apply" do
    it "extracts matching clauses from the definition" do
      clauses = double(:clauses)
      executor = spy(:executor)
      definition = double(:definition, extract: clauses)
      query = described_class.new

      query.apply(definition, executor: executor)

      expect(executor).to have_received(:new).with(clauses: clauses)
    end
  end
end
