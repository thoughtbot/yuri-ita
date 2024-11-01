require "rails_helper"

RSpec.describe "viewing documentation" do
  it "shows the readme on the root page" do
    visit root_path

    expect(page).to have_content "What is Yuri-ita?"
    expect(page).to have_content "Installation"
  end
end
