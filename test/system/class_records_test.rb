require "application_system_test_case"

class ClassRecordsTest < ApplicationSystemTestCase
  setup do
    @class_record = class_records(:one)
  end

  test "visiting the index" do
    visit class_records_url
    assert_selector "h1", text: "Class Records"
  end

  test "creating a Class record" do
    visit class_records_url
    click_on "New Class Record"

    fill_in "Description", with: @class_record.description
    fill_in "Name", with: @class_record.name
    fill_in "Phylum record", with: @class_record.phylum_record_id
    click_on "Create Class record"

    assert_text "Class record was successfully created"
    click_on "Back"
  end

  test "updating a Class record" do
    visit class_records_url
    click_on "Edit", match: :first

    fill_in "Description", with: @class_record.description
    fill_in "Name", with: @class_record.name
    fill_in "Phylum record", with: @class_record.phylum_record_id
    click_on "Update Class record"

    assert_text "Class record was successfully updated"
    click_on "Back"
  end

  test "destroying a Class record" do
    visit class_records_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Class record was successfully destroyed"
  end
end
