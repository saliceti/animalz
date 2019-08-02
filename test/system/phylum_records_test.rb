require "application_system_test_case"

class PhylumRecordsTest < ApplicationSystemTestCase
  setup do
    @phylum_record = phylum_records(:one)
  end

  test "visiting the index" do
    visit phylum_records_url
    assert_selector "h1", text: "Phylum Records"
  end

  test "creating a Phylum record" do
    visit phylum_records_url
    click_on "New Phylum Record"

    fill_in "Description", with: @phylum_record.description
    fill_in "Name", with: @phylum_record.name
    click_on "Create Phylum record"

    assert_text "Phylum record was successfully created"
    click_on "Back"
  end

  test "updating a Phylum record" do
    visit phylum_records_url
    click_on "Edit", match: :first

    fill_in "Description", with: @phylum_record.description
    fill_in "Name", with: @phylum_record.name
    click_on "Update Phylum record"

    assert_text "Phylum record was successfully updated"
    click_on "Back"
  end

  test "destroying a Phylum record" do
    visit phylum_records_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Phylum record was successfully destroyed"
  end
end
