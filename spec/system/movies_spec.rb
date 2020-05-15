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

  scenario "views a list of movies with a selected option" do
    fight_club = create(:movie, :released, title: "Fight Club")
    the_prestige = create(:movie, :rumored, title: "The Prestige")
    pretty_woman = create(:movie, :cancelled, title: "Pretty Woman")

    visit movies_path(query: "is:released")

    expect(page).to have_content("Fight Club")
    expect(page).not_to have_content("The Prestige")
    expect(page).not_to have_content("Pretty Woman")
  end

  scenario "clears active filters and searches" do
    fight_club = create(:movie, :released, title: "Fight Club")
    the_prestige = create(:movie, :rumored, title: "The Prestige")
    pretty_woman = create(:movie, :cancelled, title: "Pretty Woman")

    visit movies_path
    click_link "Released"
    click_link "Clear current search, filters, and sort"

    expect(page).to have_content("Fight Club")
    expect(page).to have_content("The Prestige")
    expect(page).to have_content("Pretty Woman")
  end
end
