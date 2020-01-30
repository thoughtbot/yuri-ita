require "spec_helper"

require "yuriita/definition/value_condition_builder"

RSpec.describe Yuriita::Definition::ValueConditionBuilder do
  describe "#build" do
    it "returns a list of filters" do
      filter = stub_value_filter
      builder = described_class.new(:label, :tag, column: :username)

      result = builder.build

      expect(result).to eq [filter]
      expect(Yuriita::Filters::ValueCondition).to have_received(:new).with(
        qualifiers: ["label", "tag"],
        column: :username,
      )
    end
  end

  def stub_value_filter
    double(:value_filter).tap do |filter|
      allow(Yuriita::Filters::ValueCondition).to(
        receive(:new).and_return(filter),
      )
    end
  end
end
