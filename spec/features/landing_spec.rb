require "rails_helper"

RSpec.describe "user views the landing page" do
  it "shows some general information" do
    visit root_path

    expect(page).to have_content "Yuri-ita"
  end
end
