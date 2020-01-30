require "spec_helper"

require "yuriita/definition/custom_condition_builder"

RSpec.describe Yuriita::Definition::CustomConditionBuilder do
  describe "#build" do
    it "returns a list of filters" do
      filter = stub_custom_filter
      builder = described_class.new(:label, :tag) do |value|
        { labels: { name: value } }
      end

      result = builder.build

      expect(result).to eq [filter]
      expect(Yuriita::Filters::CustomCondition).to have_received(:new).with(
        qualifiers: ["label", "tag"]
      )
    end
  end

  def stub_custom_filter
    double(:custom_filter).tap do |filter|
      allow(Yuriita::Filters::CustomCondition).to(
        receive(:new).and_return(filter),
      )
    end
  end
end
