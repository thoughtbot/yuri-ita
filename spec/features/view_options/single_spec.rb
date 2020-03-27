require "rails_helper"

RSpec.describe "single select options" do
  it "does not have a default" do
    visit movies_path

    expect(page).not_to have_selected_option("Adult")
    expect(page).not_to have_selected_option("Safe")
  end

  scenario "selecting a single option" do
    visit movies_path

    click_on "Adult"

    expect(page).to have_selected_option("Adult")
    expect(page).not_to have_selected_option("Safe")
  end

  scenario "selected an unselected option unselects the previous option" do
    visit movies_path

    click_on "Adult"
    click_on "Safe"

    expect(page).not_to have_selected_option("Adult")
    expect(page).to have_selected_option("Safe")
  end

  scenario "unselecting the  selected option" do
    visit movies_path

    click_on "Adult"
    click_on "Adult"

    expect(page).not_to have_selected_option("Adult")
    expect(page).not_to have_selected_option("Safe")
  end

  def have_selected_option(text)
    have_selector(".toggle-group__option.active", text: text)
  end
end
