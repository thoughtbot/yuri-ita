require "rails_helper"

RSpec.describe "multiple select options" do
  it "does not have a default" do
    visit movies_path

    expect(page).not_to have_selected_option("Rumored")
    expect(page).not_to have_selected_option("Post Production")
    expect(page).not_to have_selected_option("Released")
    expect(page).not_to have_selected_option("Cancelled")
  end

  scenario "selecting a single option" do
    visit movies_path

    click_on "Rumored"

    expect(page).to have_selected_option("Rumored")
    expect(page).not_to have_selected_option("Post Production")
    expect(page).not_to have_selected_option("Released")
    expect(page).not_to have_selected_option("Cancelled")
  end

  scenario "selecting more than one option" do
    visit movies_path

    click_on "Rumored"
    click_on "Post Production"

    expect(page).to have_selected_option("Rumored")
    expect(page).to have_selected_option("Post Production")
    expect(page).not_to have_selected_option("Released")
    expect(page).not_to have_selected_option("Cancelled")
  end

  scenario "unselecting the only selected option" do
    visit movies_path

    click_on "Rumored"
    click_on "Rumored"

    expect(page).not_to have_selected_option("Rumored")
    expect(page).not_to have_selected_option("Post Production")
    expect(page).not_to have_selected_option("Released")
    expect(page).not_to have_selected_option("Cancelled")
  end

  scenario "unslecting one option from many selected options" do
    visit movies_path

    click_on "Rumored"
    click_on "Post Production"
    click_on "Post Production"

    expect(page).to have_selected_option("Rumored")
    expect(page).not_to have_selected_option("Post Production")
    expect(page).not_to have_selected_option("Released")
    expect(page).not_to have_selected_option("Cancelled")
  end

  def have_selected_option(text)
    have_selector(".filter-list__link.active", text: text)
  end
end
