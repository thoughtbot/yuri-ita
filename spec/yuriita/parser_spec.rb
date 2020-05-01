RSpec.describe Yuriita::Parser do
  describe '#parse' do
    it "parses an empty string" do
      query = parse(tokens([:EOS]))

      expect(query.inputs).to eq []
    end

    it "parses keywords" do
      query = parse(tokens([:WORD, "hello"], [:EOS]))

      expect(query.inputs).to eq [keyword("hello")]
    end

    it "parses a keyword with an expression input" do
      query = parse(tokens(
        [:WORD, "hello"],
        [:SPACE],
        [:WORD, "label"], [:COLON], [:WORD, "bug"],
        [:EOS],
      ))

      expect(query.inputs).to contain_exactly(
        expression("label", "bug"),
        keyword("hello"),
      )
    end

    it "parses quoted keyword phrases" do
      query = parse(tokens(
        [:QUOTE],
        [:WORD, "hello"], [:SPACE], [:WORD, "world"],
        [:QUOTE],
        [:EOS],
      ))

      expect(query.inputs).to eq [keyword("hello world")]
    end

    it "parses keywords with an expression input between them" do
      query = parse(tokens(
        [:WORD, "hello"],
        [:SPACE],
        [:WORD, "label"], [:COLON], [:WORD, "bug"],
        [:SPACE],
        [:WORD, "world"],
        [:EOS],
      ))

      expect(query.inputs).to contain_exactly(
        expression("label", "bug"),
        keyword("hello"),
        keyword("world"),
      )
    end

    it "parses interspersed keywords and expression inputs" do
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

      expect(query.inputs).to contain_exactly(
        expression("label", "bug"),
        expression("label", "security"),
        keyword("hello"),
        keyword("world"),
      )
    end

    it "parses a complex mix of keywords and expression inputs" do
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

      expect(query.inputs).to contain_exactly(
        expression("label", "red"),
        expression("label", "blue"),
        expression("label", "green"),
        keyword("hello"),
        keyword("world"),
        keyword("search"),
        keyword("term"),
      )
    end

    it "parses an expression input" do
      query = parse(tokens([:WORD, "is"], [:COLON], [:WORD, "active"], [:EOS]))

      expect(query.inputs).to contain_exactly(
        expression("is", "active"),
      )
    end

    it "parses an expression input with a quoted word" do
      query = parse(tokens(
        [:WORD, "label"], [:COLON], [:QUOTE], [:WORD, "bug"], [:QUOTE], [:EOS],
      ))

      expect(query.inputs).to contain_exactly(
        expression("label", "bug"),
      )
    end

    it "parses an expression input with a quoted phrase" do
      query = parse(tokens(
        [:WORD, "label"], [:COLON], [:QUOTE], [:WORD, "bug"], [:SPACE],
        [:WORD, "report"], [:QUOTE], [:EOS],
      ))

      expect(query.inputs).to contain_exactly(
        expression("label", "bug report"),
      )
    end

    it "parses an expression input with a quoted phrase containing extra spaces" do
      query = parse(tokens(
        [:WORD, "label"], [:COLON],
        [:QUOTE],
        [:SPACE], [:WORD, "bug"], [:SPACE], [:WORD, "report"], [:SPACE],
        [:QUOTE], [:EOS],
      ))

      expect(query.inputs).to contain_exactly(
        expression("label", "bug report"),
      )
    end

    it "parses a list of expression inputs" do
      query = parse(tokens(
        [:WORD, "label"], [:COLON], [:WORD, "bug"], [:SPACE],
        [:WORD, "label"], [:COLON], [:WORD, "security"], [:SPACE],
        [:WORD, "author"], [:COLON], [:WORD, "eebs"], [:EOS],
      ))

      expect(query.inputs).to contain_exactly(
        expression("label", "bug"),
        expression("label", "security"),
        expression("author", "eebs"),
      )
    end

    it "parses a sort input" do
      query = parse(tokens(
        [:SORT], [:COLON], [:WORD, "title"], [:EOS],
      ))
      expect(query.inputs).to contain_exactly(
        sort("sort", "title")
      )
    end

    it "parses a scope input" do
      query = parse(tokens(
        [:IN], [:COLON], [:WORD, "title"], [:EOS],
      ))

      expect(query.inputs).to contain_exactly(
        scope("in", "title")
      )
    end

    it "parses a scope_input with keywords" do
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

      expect(query.inputs).to contain_exactly(
        scope("in", "title"),
        keyword("awesome"),
        keyword("ideas"),
      )
    end
  end

  def parse(tokens)
    described_class.new.parse(tokens)
  end

  def expression(qualifier, term)
    Yuriita::Inputs::Expression.new(qualifier, term)
  end

  def keyword(value)
    Yuriita::Inputs::Keyword.new(value)
  end

  def sort(qualifier, term)
    Yuriita::Inputs::Sort.new(qualifier, term)
  end

  def scope(qualifier, term)
    Yuriita::Inputs::Scope.new(qualifier, term)
  end
end
