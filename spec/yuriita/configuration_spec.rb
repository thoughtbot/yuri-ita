RSpec.describe Yuriita::Configuration do
  describe "#each" do
    it "yields each definition" do
      published = double(:definition)
      sort = double(:definition)

      config = described_class.new({published: published, sort: sort})

      expect do |b|
        config.each(&b)
      end.to yield_successive_args(published, sort)
    end
  end

  describe "#find_definition" do
    it "returns a definition by key" do
      definition = double(:definition)

      config = described_class.new({foo: definition})

      expect(config.find_definition(:foo)).to eq definition
    end

    it "raises an exception when the key does not exist" do
      config = described_class.new({})

      expect { config.find_definition(:foo) }.to raise_exception(
        KeyError,
        "key not found: :foo"
      )
    end
  end

  describe "#size" do
    it "returns the number of definitions" do
      definitions = {
        published: double(:definition),
        sort: double(:definition)
      }
      config = described_class.new(definitions)

      expect(config.size).to eq 2
    end
  end

  describe "#default_input" do
    it "returns the default input" do
      definitions = {
        published: double(:definition),
        sort: double(:definition)
      }
      config = described_class.new(definitions, default_input: "is:published")
      expect(config.default_input).to eq "is:published"
    end
  end
end
