require "spec_helper"
require "yuriita/parser"

RSpec.describe Yuriita::Parser do
  describe '#parse' do
    it "parses search terms" do
      query = stub_query

      result = parse(tokens([:WORD, "hello"], [:EOS]))

      expect(result).to eq query
      expect(Yuriita::Query).to have_received(:new).with(
        keywords: ["hello"],
        expressions: [],
        scopes: [],
      )
    end

    it "parses a search term with an expression" do
      query = stub_query

      result = parse(tokens(
        [:WORD, "hello"],
        [:SPACE],
        [:WORD, "label"], [:COLON], [:WORD, "bug"],
        [:EOS],
      ))

      expect(result).to eq query
      expect(Yuriita::Query).to have_received(:new).with(
        keywords: ["hello"],
        expressions: [expression("label", "bug")],
        scopes: [],
      )
    end

    it "parses a search terms with an expression between them" do
      query = stub_query

      result = parse(tokens(
        [:WORD, "hello"],
        [:SPACE],
        [:WORD, "label"], [:COLON], [:WORD, "bug"],
        [:SPACE],
        [:WORD, "world"],
        [:EOS],
      ))

      expect(result).to eq query
      expect(Yuriita::Query).to have_received(:new).with(
        keywords: ["hello", "world"],
        expressions: [expression("label", "bug")],
        scopes: [],
      )
    end

    it "parses interspersed keywords and expressions" do
      query = stub_query

      result = parse(tokens(
        [:WORD, "hello"],
        [:SPACE],
        [:WORD, "label"], [:COLON], [:WORD, "bug"],
        [:SPACE],
        [:WORD, "world"],
        [:SPACE],
        [:WORD, "label"], [:COLON], [:WORD, "security"],
        [:EOS],
      ))

      expect(result).to eq query
      expect(Yuriita::Query).to have_received(:new).with(
        keywords: ["hello", "world"],
        expressions: [
          expression("label", "bug"),
          expression("label", "security"),
        ],
        scopes: [],
      )
    end

    it "parses a complex mix of keywords and expression" do
      query = stub_query

      result = parse(tokens(
        [:WORD, "hello"],
        [:SPACE],
        [:WORD, "world"],
        [:SPACE],
        [:WORD, "label"], [:COLON], [:WORD, "red"],
        [:SPACE],
        [:WORD, "label"], [:COLON], [:WORD, "blue"],
        [:SPACE],
        [:WORD, "search"],
        [:SPACE],
        [:WORD, "label"], [:COLON], [:WORD, "green"],
        [:SPACE],
        [:WORD, "term"],
        [:EOS],
      ))

      expect(result).to eq query
      expect(Yuriita::Query).to have_received(:new).with(
        keywords: ["hello", "world", "search", "term"],
        expressions: [
          expression("label", "red"),
          expression("label", "blue"),
          expression("label", "green"),
        ],
        scopes: [],
      )
    end

    it "parses an expression" do
      query = stub_query

      result = parse(tokens([:WORD, "is"], [:COLON], [:WORD, "active"], [:EOS]))

      expect(result).to eq query
      expect(Yuriita::Query).to have_received(:new).with(
        keywords: [],
        expressions: [expression("is", "active")],
        scopes: [],
      )
    end

    it "parses an expression with a quoted word" do
      query = stub_query

      result = parse(tokens(
        [:WORD, "label"], [:COLON], [:QUOTE], [:WORD, "bug"], [:QUOTE], [:EOS],
      ))

      expect(result).to eq query
      expect(Yuriita::Query).to have_received(:new).with(
        keywords: [],
        expressions: [expression("label", "bug")],
        scopes: [],
      )
    end

    it "parses an expression with a quoted phrase" do
      query = stub_query

      result = parse(tokens(
        [:WORD, "label"], [:COLON], [:QUOTE], [:WORD, "bug"], [:SPACE],
        [:WORD, "report"], [:QUOTE], [:EOS],
      ))

      expect(result).to eq query
      expect(Yuriita::Query).to have_received(:new).with(
        keywords: [],
        expressions: [expression("label", "bug report")],
        scopes: [],
      )
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
      expect(Yuriita::Query).to have_received(:new).with(
        keywords: [],
        expressions: [expression("label", "bug report")],
        scopes: [],
      )
    end

    it "parses a list of expressions" do
      query = stub_query

      result = parse(tokens(
        [:WORD, "label"], [:COLON], [:WORD, "bug"], [:SPACE],
        [:WORD, "label"], [:COLON], [:WORD, "security"], [:SPACE],
        [:WORD, "author"], [:COLON], [:WORD, "eebs"], [:EOS],
      ))

      expect(result).to eq query
      expect(Yuriita::Query).to have_received(:new).with(
        keywords: [],
        expressions: [
          expression("label", "bug"),
          expression("label", "security"),
          expression("author", "eebs"),
        ],
        scopes: [],
      )
    end

    it "parses a negated qualifier" do
      query = stub_query

      result = parse(tokens(
        [:NEGATION], [:WORD, "label"], [:COLON], [:WORD, "bug"], [:EOS],
      ))

      expect(result).to eq query
      expect(Yuriita::Query).to have_received(:new).with(
        keywords: [],
        expressions: [negated_expression("label", "bug")],
        scopes: [],
      )
    end

    it "parses a negated qualifier with a non-negated qualifier" do
      query = stub_query

      result = parse(tokens(
        [:NEGATION], [:WORD, "label"], [:COLON], [:WORD, "bug"], [:SPACE],
        [:WORD, "label"], [:COLON], [:WORD, "security"], [:EOS],
      ))

      expect(result).to eq query
      expect(Yuriita::Query).to have_received(:new).with(
        keywords: [],
        expressions: [
          negated_expression("label", "bug"),
          expression("label", "security"),
        ],
        scopes: [],
      )
    end

    it "parses a keyword scope" do
      query = stub_query

      result = parse(tokens(
        [:IN], [:COLON], [:WORD, "title"], [:EOS],
      ))

      expect(result).to eq query
      expect(Yuriita::Query).to have_received(:new).with(
        keywords: [],
        expressions: [],
        scopes: [ { scope: "title" } ],
      )
    end

    it "parses a keyword scope with keywords" do
      query = stub_query

      result = parse(tokens(
        [:WORD, "awesome"],
        [:SPACE],
        [:IN],
        [:COLON],
        [:WORD, "title"],
        [:SPACE],
        [:WORD, "ideas"],
        [:EOS],
      ))

      expect(result).to eq query
      expect(Yuriita::Query).to have_received(:new).with(
        keywords: ["awesome", "ideas"],
        expressions: [],
        scopes: [ { scope: "title" } ],
      )
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
    Yuriita::NegatedExpression.new(qualifier: qualifier, term: term)
  end
end
