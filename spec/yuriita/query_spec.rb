RSpec.describe Yuriita::Query do
  describe "#keywords" do
    it "returns the initialized keywords" do
      keywords = double(:keywords)
      query = described_class.new(keywords: keywords)

      expect(query.keywords).to eq keywords
    end
  end

  describe "#inputs" do
    it "returns the initialized" do
      inputs = double(:inputs)
      query = described_class.new(inputs: inputs)

      expect(query.inputs).to eq inputs
    end
  end

  describe "#dup" do
    it "duplicates the inputs" do
      input = Yuriita::Query::Input.new(qualifier: "is", term: "original")
      new_input = Yuriita::Query::Input.new(qualifier: "is", term: "new")
      original = described_class.new(inputs: [input])

      duplicate = original.dup
      duplicate << new_input

      expect(duplicate.inputs).to include(input)
      expect(original.inputs).not_to include(new_input)
    end
  end

  describe "#clone" do
    it "duplicates the inputs" do
      input = Yuriita::Query::Input.new(qualifier: "is", term: "original")
      new_input = Yuriita::Query::Input.new(qualifier: "is", term: "new")
      original = described_class.new(inputs: [input])

      duplicate = original.clone
      duplicate << new_input

      expect(duplicate.inputs).to include(input)
      expect(original.inputs).not_to include(new_input)
    end
  end

  describe "#each" do
    it "yields the inputs" do
      published = build(:input, qualifier: "is", term: "published")
      draft = build(:input, qualifier: "is", term: "draft")
      query = described_class.new(inputs: [published, draft])

      expect do |b|
        query.each(&b)
      end.to yield_successive_args(published, draft)
    end
  end

  describe "#each_element" do
    it "yields inputs and keywords" do
      published = build(:input, qualifier: "is", term: "published")
      draft = build(:input, qualifier: "is", term: "draft")
      query = described_class.new(inputs: [published, draft], keywords: ["cat"])

      expect do |b|
        query.each_element(&b)
      end.to yield_successive_args(published, draft, "cat")
    end
  end

  describe "#add_input" do
    it "adds an input to the query" do
      published = build(:input, qualifier: "is", term: "published")
      query = described_class.new(inputs: [])

      query.add_input(published)

      expect(query).to include(published)
    end
  end

  describe "#include?" do
    it "is true if the query contains the input" do
      published = build(:input, qualifier: "is", term: "published")
      draft = build(:input, qualifier: "is", term: "draft")

      query = described_class.new(inputs: [published, draft])

      expect(query).to include(published)
    end

    it "is false if the query does not contain the input" do
      published = build(:input, qualifier: "is", term: "published")
      query = described_class.new(inputs: [])

      expect(query).not_to include(published)
    end
  end

  describe "#delete_if" do
    it "removes inputs matching the block" do
      published = build(:input, qualifier: "is", term: "published")
      draft = build(:input, qualifier: "is", term: "draft")
      query = described_class.new(inputs: [published, draft])

      query.delete_if { |input| input == published }

      expect(query).not_to include(published)
      expect(query).to include(draft)
    end
  end

  describe "#size" do
    it "returns the number of inputs" do
      published = build(:input, qualifier: "is", term: "published")
      draft = build(:input, qualifier: "is", term: "draft")

      query = described_class.new(inputs: [published, draft])

      expect(query.size).to eq 2
    end

    it "returns zero when there are no inputs" do
      query = described_class.new

      expect(query.size).to eq 0
    end
  end
end
