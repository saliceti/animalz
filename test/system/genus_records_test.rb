require "application_system_test_case"

class GenusRecordsTest < ApplicationSystemTestCase
  setup do
    @genus_record = genus_records(:one)
  end

  test "visiting the index" do
    visit genus_records_url
    assert_selector "h1", text: "Genus Records"
  end

  test "creating a Genus record" do
    visit genus_records_url
    click_on "New Genus Record"

    fill_in "Description", with: @genus_record.description
    fill_in "Family record", with: @genus_record.family_record_id
    fill_in "Name", with: @genus_record.name
    click_on "Create Genus record"

    assert_text "Genus record was successfully created"
    click_on "Back"
  end

  test "updating a Genus record" do
    visit genus_records_url
    click_on "Edit", match: :first

    fill_in "Description", with: @genus_record.description
    fill_in "Family record", with: @genus_record.family_record_id
    fill_in "Name", with: @genus_record.name
    click_on "Update Genus record"

    assert_text "Genus record was successfully updated"
    click_on "Back"
  end

  test "destroying a Genus record" do
    visit genus_records_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Genus record was successfully destroyed"
  end
end
