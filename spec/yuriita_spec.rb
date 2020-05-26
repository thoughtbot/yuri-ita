RSpec.describe Yuriita do
  it "has a version number" do
    expect(Yuriita::VERSION).not_to be nil
  end

  describe ".filter" do
    it "returns an error result when the input could not be parsed" do
      relation = double(:relation)
      definition = double(:definition)

      result = Yuriita.filter(relation, "invalid::", definition)

      expect(result).not_to be_successful
    end

    it "returns a success result when the input was valid" do
      relation = double(:relation)
      definition = double(:definition)
      stub_runner_success(relation)

      result = Yuriita.filter(relation, "is:published", definition)

      expect(result).to be_successful
    end
  end

  describe ".build_query" do
    it "returns a Query when the input is valid" do
      query = Yuriita.build_query("is:published")

      expect(query).to be_a(Yuriita::Query)
    end

    it "raises a ParseError when the input is invalid" do
      expect { Yuriita.build_query("inavlid::") }.to raise_error(
        Yuriita::ParseError
      )
    end
  end

  def stub_runner_success(relation)
    runner = double(:runner, run: relation)
    allow(Yuriita::Runner).to receive(:new).and_return(runner)
  end
end
