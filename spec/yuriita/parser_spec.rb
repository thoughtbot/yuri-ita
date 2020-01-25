require "spec_helper"
require "yuriita/parser"
require "yuriita/query"
require "yuriita/expression"

RSpec.describe Yuriita::Parser do
  describe '#parse' do
    it "parses an expression" do
      query = stub_query

      result = parse(tokens([:WORD, "is"], [:COLON], [:WORD, "active"], [:EOS]))

      expect(result).to eq query
      expect(Yuriita::Query).to have_received(:new).with([
        expression("is", "active"),
      ])
    end

    it "parses an expression with a quoted word" do
      query = stub_query

      result = parse(tokens(
        [:WORD, "label"], [:COLON], [:QUOTE], [:WORD, "bug"], [:QUOTE], [:EOS],
      ))

      expect(result).to eq query
      expect(Yuriita::Query).to have_received(:new).with([
        expression("label", "bug"),
      ])
    end

    it "parses an expression with a quoted phrase" do
      query = stub_query

      result = parse(tokens(
        [:WORD, "label"], [:COLON], [:QUOTE], [:WORD, "bug"], [:SPACE],
        [:WORD, "report"], [:QUOTE], [:EOS],
      ))

      expect(result).to eq query
      expect(Yuriita::Query).to have_received(:new).with([
        expression("label", "bug report")
      ])
    end

    it "parses an expression with a quoted phrase containing extra spaces" do
      query = stub_query

      result = parse(tokens(
        [:WORD, "label"], [:COLON],
        [:QUOTE],
        [:SPACE], [:WORD, "bug"], [:SPACE], [:WORD, "report"], [:SPACE],
        [:QUOTE], [:EOS],
      ))

      expect(result).to eq query
      expect(Yuriita::Query).to have_received(:new).with([
        expression("label", "bug report")
      ])
    end

    it "parses a list of expressions" do
      query = stub_query

      result = parse(tokens(
        [:WORD, "label"], [:COLON], [:WORD, "bug"], [:SPACE],
        [:WORD, "label"], [:COLON], [:WORD, "security"], [:SPACE],
        [:WORD, "author"], [:COLON], [:WORD, "eebs"], [:EOS],
      ))

      expect(result).to eq query
      expect(Yuriita::Query).to have_received(:new).with([
        expression("label", "bug"),
        expression("label", "security"),
        expression("author", "eebs"),
      ])
    end

    it "parses a negated qualifier" do
      query = stub_query

      result = parse(tokens(
        [:NEGATION], [:WORD, "label"], [:COLON], [:WORD, "bug"], [:EOS],
      ))

      expect(result).to eq query
      expect(Yuriita::Query).to have_received(:new).with([
        negated_expression("label", "bug")
      ])
    end

    it "parses a negated qualifier with a non-negated qualifier" do
      query = stub_query

      result = parse(tokens(
        [:NEGATION], [:WORD, "label"], [:COLON], [:WORD, "bug"], [:SPACE],
        [:WORD, "label"], [:COLON], [:WORD, "security"], [:EOS],
      ))

      expect(result).to eq query
      expect(Yuriita::Query).to have_received(:new).with([
        negated_expression("label", "bug"),
        expression("label", "security"),
      ])
    end
  end

  def stub_query
    double(:query).tap do |query|
      allow(Yuriita::Query).to receive(:new).and_return(query)
    end
  end

  def parse(tokens)
    described_class.new.parse(tokens)
  end

  def expression(qualifier, term)
    Yuriita::Expression.new(qualifier: qualifier, term: term)
  end

  def negated_expression(qualifier, term)
    Yuriita::Expression.new(qualifier: qualifier, term: term, negated: true)
  end
end
