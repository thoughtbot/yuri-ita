require "spec_helper"
require "yuriita/parser"

RSpec.describe Yuriita::Parser do
  describe '#parse' do
    it "parses an expression" do
      result = parse(tokens([:WORD, "is"], [:COLON], [:WORD, "active"], [:EOS]))

      expect(result).to eq(key: "is", value: "active")
    end
  end

  def parse(tokens)
    described_class.new.parse(tokens)
  end
end
