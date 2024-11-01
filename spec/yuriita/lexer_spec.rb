RSpec.describe Yuriita::Lexer do
  describe ".lex" do
    it "recognizes colon separated words" do
      expect("is:active").to produce_tokens(
        [
          "WORD(is)",
          "COLON",
          "WORD(active)",
          "EOS"
        ]
      )
    end

    it "recognizes bare words" do
      expect("first last").to produce_tokens(
        [
          "WORD(first)",
          "SPACE",
          "WORD(last)",
          "EOS"
        ]
      )
    end

    it "recognizes words with underscores" do
      expect("created_by:eebs").to produce_tokens(
        [
          "WORD(created_by)",
          "COLON",
          "WORD(eebs)",
          "EOS"
        ]
      )
    end

    it "recognizes words with hyphens" do
      expect("sort:created-desc").to produce_tokens(
        [
          "WORD(sort)",
          "COLON",
          "WORD(created-desc)",
          "EOS"
        ]
      )
    end

    it "recognizes words with non-alpha characters" do
      expect("email:user.name123@example.com").to produce_tokens(
        [
          "WORD(email)",
          "COLON",
          "WORD(user.name123@example.com)",
          "EOS"
        ]
      )
    end

    it "recognizes quoted words" do
      expect("\"quoted words\"").to produce_tokens(
        [
          "QUOTE",
          "WORD(quoted)",
          "SPACE",
          "WORD(words)",
          "QUOTE",
          "EOS"
        ]
      )
    end

    it "recognizes dates" do
      input = "created:>2020-01-01"
      expect(input).to produce_tokens(
        [
          "WORD(created)",
          "COLON",
          "GT",
          "DATETIME(2020-01-01T00:00:00+00:00)",
          "EOS"
        ]
      )
    end

    it "recognizes dates with a time and timezone offset" do
      input = "created:>2020-01-01T15:30:00+03:00"
      expect(input).to produce_tokens(
        [
          "WORD(created)",
          "COLON",
          "GT",
          "DATETIME(2020-01-01T15:30:00+03:00)",
          "EOS"
        ]
      )
    end

    it "recognizes dates with a time and UTC offset" do
      input = "created:>2020-01-01T15:30:00Z"
      expect(input).to produce_tokens(
        [
          "WORD(created)",
          "COLON",
          "GT",
          "DATETIME(2020-01-01T15:30:00+00:00)",
          "EOS"
        ]
      )
    end
  end
end
