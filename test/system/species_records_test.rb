require "application_system_test_case"

class SpeciesRecordsTest < ApplicationSystemTestCase
  setup do
    @species_record = species_records(:one)
  end

  test "visiting the index" do
    visit species_records_url
    assert_selector "h1", text: "Species Records"
  end

  test "creating a Species record" do
    visit species_records_url
    click_on "New Species Record"

    fill_in "Description", with: @species_record.description
    fill_in "Genus record", with: @species_record.genus_record_id
    fill_in "Name", with: @species_record.name
    click_on "Create Species record"

    assert_text "Species record was successfully created"
    click_on "Back"
  end

  test "updating a Species record" do
    visit species_records_url
    click_on "Edit", match: :first

    fill_in "Description", with: @species_record.description
    fill_in "Genus record", with: @species_record.genus_record_id
    fill_in "Name", with: @species_record.name
    click_on "Update Species record"

    assert_text "Species record was successfully updated"
    click_on "Back"
  end

  test "destroying a Species record" do
    visit species_records_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Species record was successfully destroyed"
  end
end
