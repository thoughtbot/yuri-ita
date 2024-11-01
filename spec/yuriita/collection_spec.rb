require "rails_helper"

RSpec.describe Yuriita::Collection do
  describe ".routing" do
  end

  describe ".route" do
    it "routes by string" do
      collection = Class.new(described_class) do
        routing "is:published", to: :published

        def published(relation)
          "abc123"
        end
      end
      input = create(:expression, qualifier: "is", term: "published")

      result = collection.route(input, double(:relation))

      expect(result).to eq "abc123"
    end
  end

  describe ".dispatch" do
    it "calls the action and returns the result" do
      collection = Class.new(described_class) do
        def published(relation)
          "abc123"
        end
      end
      input = double(:input)

      result = collection.dispatch(:published, input, double(:relation))

      expect(result).to eq "abc123"
    end

    it "raises ActionNotFound when dispatching an invalid action" do
      collection = Class.new(described_class) do
        def published(relation)
          "abc123"
        end
      end
      Object.send :const_set, :ExampleCollection, collection
      input = double(:input)

      expect do
        collection.dispatch(:not_defined, input, double(:relation))
      end.to raise_error(
        Yuriita::Collection::ActionNotFound,
        "The action 'not_defined' could not be found for ExampleCollection"
      )
    ensure
      Object.send :remove_const, :ExampleCollection
    end

    it "raises ActionNotFound when dispatching an internal method" do
      collection = Class.new(described_class)
      Object.send :const_set, :ExampleCollection, collection
      input = double(:input)

      expect do
        collection.dispatch(:find_method_name, input, double(:relation))
      end.to raise_error(
        Yuriita::Collection::ActionNotFound,
        "The action 'find_method_name' could not be found for ExampleCollection"
      )
    ensure
      Object.send :remove_const, :ExampleCollection
    end
  end
end
