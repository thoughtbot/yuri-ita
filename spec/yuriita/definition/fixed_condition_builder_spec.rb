require "spec_helper"

require "yuriita/definition/fixed_condition_builder"

RSpec.describe Yuriita::Definition::FixedConditionBuilder do
  describe "#build" do
    it "returns a list of filters" do
      filter = stub_fixed_filter
      builder = described_class.new("is:open", "state:open", state: :open)

      result = builder.build

      expect(result).to eq [filter]
      expect(Yuriita::Filters::FixedCondition).to have_received(:new).with(
        expressions: [
          expression("is:open"),
          expression("state:open"),
        ],
        conditions: { state: :open },
      )
    end
  end

  def stub_fixed_filter
    double(:fixed_filter).tap do |filter|
      allow(Yuriita::Filters::FixedCondition).to(
        receive(:new).and_return(filter),
      )
    end
  end

  def expression(string)
    Yuriita::Definition::Expression.new(string)
  end
end
