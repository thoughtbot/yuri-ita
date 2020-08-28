RSpec.describe Yuriita::Router do
  describe "string routing" do
    it "routes " do
      collection = build_collection
      router = described_class.new
      router.append_route(collection, "is:published", to: :published)
      input = expression("is", "published")

      relation = {}
      router.route(input, relation)

      expect(relation[:published]).to eq input
    end
  end

  describe "matching with a Proc" do
    it "matches if the Proc returns true" do
      collection = build_collection
      router = described_class.new
      router.append_route(
        collection,
        ->(input) { input.term == "published" },
        to: :published,
      )
      input = expression("is", "published")

      relation = {}
      router.route(input, relation)

      expect(relation[:published]).to eq input
    end
  end

  describe "matching with an object" do
    it "matches if calling #matches? is true" do
      collection = build_collection
      router = described_class.new
      router.append_route(collection, custom_matcher.new, to: :published)
      input = expression("is", "published")

      relation = {}
      router.route(input, relation)

      expect(relation[:published]).to eq input
    end
  end

  def build_collection
    Class.new(Yuriita::Collection) do
      def published(relation)
        relation[:published] = input
      end

      def draft(relation)
        relation[:draft] = input
      end
    end
  end

  def expression(qualifier, term)
    Yuriita::Inputs::Expression.new(qualifier, term)
  end

  def custom_matcher
    Class.new do
      def match?(input)
        input.term == "published"
      end
    end
  end
end
