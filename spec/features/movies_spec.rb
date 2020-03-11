require "rails_helper"

RSpec.describe "user views the movies page" do
  scenario "views a list of movies" do
    fight_club = create(:movie, title: "Fight Club")
    the_prestige = create(:movie, title: "The Prestige")
    pretty_woman = create(:movie, title: "Pretty Woman")

    visit movies_path

    expect(page).to have_content("Fight Club")
    expect(page).to have_content("The Prestige")
    expect(page).to have_content("Pretty Woman")
  end
end
