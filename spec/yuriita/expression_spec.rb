require "spec_helper"
require "yuriita/expression"

RSpec.describe Yuriita::Expression do
  describe "negated?" do
    it "is false" do
      expression = described_class.new(qualifier: "is", term: "active")

      expect(expression).not_to be_negated
    end
  end

  describe "#qualifier" do
    it "returns the provided qualifier" do
      expression = described_class.new(qualifier: "is", term: "active")

      expect(expression.qualifier).to eq "is"
    end
  end

  describe "#term" do
    it "returns the provided term" do
      expression = described_class.new(qualifier: "is", term: "active")

      expect(expression.term).to eq "active"
    end
  end

  describe "#==" do
    it "returns true when the qualifier and term are equal" do
      expression1 = described_class.new(qualifier: "q", term: "t")
      expression2 = described_class.new(qualifier: "q", term: "t")

      expect(expression1).to eq expression2
    end

    it "returns false when the qualifiers are different" do
      a = described_class.new(qualifier: "a", term: "t")
      b = described_class.new(qualifier: "b", term: "t")

      expect(a).not_to eq b
    end

    it "returns false when the terms are different" do
      a = described_class.new(qualifier: "q", term: "a")
      b = described_class.new(qualifier: "q", term: "b")

      expect(a).not_to eq b
    end

    it "returns false when the other object has a different class" do
      expression = described_class.new(qualifier: "q", term: "t")
      double_expression = double(qualifier: "q", term: "t")

      expect(expression).not_to eq double_expression
    end
  end
end
