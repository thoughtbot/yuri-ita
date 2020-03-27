require "rails_helper"

RSpec.describe "exclusive select options" do
  it "has a default" do
    visit movies_path

    expect(page).to have_selected_option("Rating")
    expect(page).not_to have_selected_option("Title Asc")
    expect(page).not_to have_selected_option("Title Desc")
  end

  scenario "selecting an unselected option unselects the previous option" do
    visit movies_path

    click_on "Title Asc"

    expect(page).not_to have_selected_option("Rating")
    expect(page).to have_selected_option("Title Asc")
    expect(page).not_to have_selected_option("Title Desc")
  end

  scenario "selecting a selected option causes no change" do
    visit movies_path

    click_on "Rating"

    expect(page).to have_selected_option("Rating")
    expect(page).not_to have_selected_option("Title Asc")
    expect(page).not_to have_selected_option("Title Desc")
  end

  def have_selected_option(text)
    have_selector(".toggle-group__option.active", text: text)
  end
end
