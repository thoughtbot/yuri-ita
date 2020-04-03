RSpec.describe Yuriita::Option do
  it "equality is based on the option's name" do
    filter = double(:filter)
    option_a = described_class.new(name: "One", filter: filter)
    option_b = described_class.new(name: "One", filter: filter)
    option_c = described_class.new(name: "Two", filter: filter)

    expect(option_a).to eq(option_a)
    expect(option_a).to eq(option_b)
    expect(option_a).not_to eq(option_c)
  end
end
