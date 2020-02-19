require "spec_helper"
require "yuriita/parser"

RSpec.describe Yuriita::Parser do
  describe '#parse' do
    it "parses search terms" do
      query = parse(tokens([:WORD, "hello"], [:EOS]))

      expect(query.keywords).to eq ["hello"]
    end

    it "parses a search term with an expression" do
      query = parse(tokens(
        [:WORD, "hello"],
        [:SPACE],
        [:WORD, "label"], [:COLON], [:WORD, "bug"],
        [:EOS],
      ))

      expect(query.keywords).to eq ["hello"]
      expect(query.expressions).to eq [expression("label", "bug")]
    end

    it "parses a search terms with an expression between them" do
      query = parse(tokens(
        [:WORD, "hello"],
        [:SPACE],
        [:WORD, "label"], [:COLON], [:WORD, "bug"],
        [:SPACE],
        [:WORD, "world"],
        [:EOS],
      ))

      expect(query.keywords).to eq ["hello", "world"]
      expect(query.expressions).to eq [expression("label", "bug")]
    end

    it "parses interspersed keywords and expressions" do
      query = parse(tokens(
        [:WORD, "hello"],
        [:SPACE],
        [:WORD, "label"], [:COLON], [:WORD, "bug"],
        [:SPACE],
        [:WORD, "world"],
        [:SPACE],
        [:WORD, "label"], [:COLON], [:WORD, "security"],
        [:EOS],
      ))


      expect(query.keywords).to eq ["hello", "world"]
      expect(query.expressions).to eq(
        [
          expression("label", "bug"),
          expression("label", "security"),
        ]
      )
    end

    it "parses a complex mix of keywords and expression" do
      query = parse(tokens(
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

      expect(query.keywords).to eq ["hello", "world", "search", "term"]
      expect(query.expressions).to eq(
        [
          expression("label", "red"),
          expression("label", "blue"),
          expression("label", "green"),
        ]
      )
    end

    it "parses an expression" do
      query = parse(tokens([:WORD, "is"], [:COLON], [:WORD, "active"], [:EOS]))

      expect(query.expressions).to eq [expression("is", "active")]
    end

    it "parses an expression with a quoted word" do
      query = parse(tokens(
        [:WORD, "label"], [:COLON], [:QUOTE], [:WORD, "bug"], [:QUOTE], [:EOS],
      ))

      expect(query.expressions).to eq [expression("label", "bug")]
    end

    it "parses an expression with a quoted phrase" do
      query = parse(tokens(
        [:WORD, "label"], [:COLON], [:QUOTE], [:WORD, "bug"], [:SPACE],
        [:WORD, "report"], [:QUOTE], [:EOS],
      ))

      expect(query.expressions).to eq [expression("label", "bug report")]
    end

    it "parses an expression with a quoted phrase containing extra spaces" do
      query = parse(tokens(
        [:WORD, "label"], [:COLON],
        [:QUOTE],
        [:SPACE], [:WORD, "bug"], [:SPACE], [:WORD, "report"], [:SPACE],
        [:QUOTE], [:EOS],
      ))

      expect(query.expressions).to eq [expression("label", "bug report")]
    end

    it "parses a list of expressions" do
      query = parse(tokens(
        [:WORD, "label"], [:COLON], [:WORD, "bug"], [:SPACE],
        [:WORD, "label"], [:COLON], [:WORD, "security"], [:SPACE],
        [:WORD, "author"], [:COLON], [:WORD, "eebs"], [:EOS],
      ))

      expect(query.expressions).to eq(
        [
          expression("label", "bug"),
          expression("label", "security"),
          expression("author", "eebs"),
        ]
      )
    end

    it "parses a negated qualifier" do
      query = parse(tokens(
        [:NEGATION], [:WORD, "label"], [:COLON], [:WORD, "bug"], [:EOS],
      ))

      expect(query.expressions).to eq [negated_expression("label", "bug")]
    end

    it "parses a negated qualifier with a non-negated qualifier" do
      query = parse(tokens(
        [:NEGATION], [:WORD, "label"], [:COLON], [:WORD, "bug"], [:SPACE],
        [:WORD, "label"], [:COLON], [:WORD, "security"], [:EOS],
      ))

      expect(query.expressions).to eq(
        [
          negated_expression("label", "bug"),
          expression("label", "security"),
        ]
      )
    end

    it "parses a keyword scope" do
      query = parse(tokens(
        [:IN], [:COLON], [:WORD, "title"], [:EOS],
      ))

      expect(query.scopes).to eq [ { scope: "title" } ]
    end

    it "parses a keyword scope with keywords" do
      query = parse(tokens(
        [:WORD, "awesome"],
        [:SPACE],
        [:IN],
        [:COLON],
        [:WORD, "title"],
        [:SPACE],
        [:WORD, "ideas"],
        [:EOS],
      ))

      expect(query.keywords).to eq ["awesome", "ideas"]
      expect(query.scopes).to eq [ { scope: "title" } ]
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
