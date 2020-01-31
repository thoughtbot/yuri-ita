require "spec_helper"
require "yuriita/definition/expression"

RSpec.describe Yuriita::Definition::Expression do
  describe "valid arguments" do
    it "accepts a string" do
      expect { described_class.new("is:open") }.not_to raise_error
    end

    it "requires a string" do
      expect do
        described_class.new(:wrong)
      end.to raise_error(
        ArgumentError,
        "Definition expression must be a string, received Symbol instead"
      )
    end

    it "raises when invalid" do
      expect do
        described_class.new("word")
      end.to raise_error(
        ArgumentError,
        <<-ERROR.squish
          Invalid definition expression "word".
          Expression should take the form "qualifier:term"
        ERROR
      )
    end

    it "does not allow 'foo:'" do
      expect do
        described_class.new("foo:")
      end.to raise_error(
        ArgumentError,
        <<-ERROR.squish
          Invalid definition expression "foo:".
          Expression should take the form "qualifier:term"
        ERROR
      )
    end

    it "does not allow ':foo'" do
      expect do
        described_class.new("foo:")
      end.to raise_error(
        ArgumentError,
        <<-ERROR.squish
          Invalid definition expression "foo:".
          Expression should take the form "qualifier:term"
        ERROR
      )
    end

    it "does not allow 'is:open:what'" do
      expect do
        described_class.new("is:open:what")
      end.to raise_error(
        ArgumentError,
        <<-ERROR.squish
          Invalid definition expression "is:open:what".
          Expression should take the form "qualifier:term"
        ERROR
      )
    end
  end
end
