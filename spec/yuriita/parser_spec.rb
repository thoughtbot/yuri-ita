require "spec_helper"
require "yuriita/parser"

RSpec.describe Yuriita::Parser do
  describe '#parse' do
    it "parses an expression" do
      result = parse(tokens([:WORD, "is"], [:COLON], [:WORD, "active"], [:EOS]))

      expect(result).to eq [{ key: "is", value: "active" }]
    end

    it "parses an expression with a quoted word" do
      result = parse(tokens(
        [:WORD, "label"], [:COLON], [:QUOTE], [:WORD, "bug"], [:QUOTE], [:EOS],
      ))

      expect(result).to eq [{ key: "label", value: "bug" }]
    end

    it "parses an expression with a quoted phrase" do
      result = parse(tokens(
        [:WORD, "label"], [:COLON], [:QUOTE], [:WORD, "bug"], [:SPACE],
        [:WORD, "report"], [:QUOTE], [:EOS],
      ))

      expect(result).to eq [{ key: "label", value: "bug report" }]
    end

    it "parses an expression with a quoted phrase containing extra spaces" do
      result = parse(tokens(
        [:WORD, "label"], [:COLON],
        [:QUOTE],
        [:SPACE], [:WORD, "bug"], [:SPACE], [:WORD, "report"], [:SPACE],
        [:QUOTE], [:EOS],
      ))

      expect(result).to eq [{ key: "label", value: "bug report" }]
    end

    it "parses a list of expressions" do
      result = parse(tokens(
        [:WORD, "label"], [:COLON], [:WORD, "bug"], [:SPACE],
        [:WORD, "label"], [:COLON], [:WORD, "security"], [:SPACE],
        [:WORD, "author"], [:COLON], [:WORD, "eebs"], [:EOS],
      ))

      expect(result).to eq [
        { key: "label", value: "bug" },
        { key: "label", value: "security" },
        { key: "author", value: "eebs" },
      ]
    end
  end

  def parse(tokens)
    described_class.new.parse(tokens)
  end
end
