require "rails_helper"

RSpec.describe Yuriita::Clauses::Identity do
  describe "#apply" do
    it "returns the given relation with no changes" do
      relation = double(:relation)

      clause = described_class.new
      result = clause.apply(relation)

      expect(result).to eq(relation)
    end
  end
end
