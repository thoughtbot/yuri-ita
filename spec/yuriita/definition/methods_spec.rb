require "spec_helper"
require "yuriita/definition/methods"
require "yuriita/definition/custom_condition_builder"
require "yuriita/definition/value_condition_builder"

RSpec.describe Yuriita::Definition::Methods do
  describe ".fixed" do
    it "allows a list of expressions and a hash of conditions" do
      allow(Yuriita::QueryDefinition).to receive(:new)
      filter = stub_fixed_filter
      klass = Class.new do
        include Yuriita::Definition::Methods

        fixed "is:open", "state:open", active: true
      end

      definition = klass.to_definition

      expect(Yuriita::Filters::FixedCondition).to have_received(:new).with(
        expressions: [["is", "open"], ["state", "open"]],
        conditions: { active: true },
      )
      expect(Yuriita::QueryDefinition).to have_received(:new).with(
        filters: [filter],
      )
    end
  end

  describe ".value" do
    it "adds a value condition when given conditions" do
      filters = stub_value_builder

      klass = Class.new do
        include Yuriita::Definition::Methods

        value(:author, :user, column: :username)
      end

      expect(Yuriita::Definition::ValueConditionBuilder).to(
        have_received(:new).with(:author, :user, column: :username)
      )
      expect(klass.filters).to eq filters
    end

    it "adds a custom condition when given a block" do
      filters = stub_custom_builder
      condition_block = ->(value) { value }

      klass = Class.new do
        include Yuriita::Definition::Methods

        value(:author, :user, &condition_block)
      end

      expect(Yuriita::Definition::CustomConditionBuilder).to(
        have_received(:new).with(:author, :user)
      ) do |&block|
        expect(block).to eq(condition_block)
      end
      expect(klass.filters).to eq filters
    end
  end

  def stub_custom_builder
    filter = double(:filter)
    builder = double(:custom_builder)
    allow(Yuriita::Definition::CustomConditionBuilder).to(
      receive(:new).and_return(builder)
    )
    allow(builder).to receive(:build).and_return([filter])
    [filter]
  end

  def stub_value_builder
    filter = double(:filter)
    builder = double(:value_builder)
    allow(Yuriita::Definition::ValueConditionBuilder).to(
      receive(:new).and_return(builder)
    )
    allow(builder).to receive(:build).and_return([filter])
    [filter]
  end

  def stub_fixed_filter
    double(:filter).tap do |filter|
      allow(Yuriita::Filters::FixedCondition).to receive(:new).and_return(filter)
    end
  end

  def stub_value_filter
    double(:filter).tap do |filter|
      allow(Yuriita::Filters::ValueCondition).to receive(:new).and_return(filter)
    end
  end

  def stub_custom_filter
    double(:filter).tap do |filter|
      allow(Yuriita::Filters::CustomCondition).to receive(:new).and_return(filter)
    end
  end
end
