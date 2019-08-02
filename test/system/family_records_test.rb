require "application_system_test_case"

class FamilyRecordsTest < ApplicationSystemTestCase
  setup do
    @family_record = family_records(:one)
  end

  test "visiting the index" do
    visit family_records_url
    assert_selector "h1", text: "Family Records"
  end

  test "creating a Family record" do
    visit family_records_url
    click_on "New Family Record"

    fill_in "Description", with: @family_record.description
    fill_in "Name", with: @family_record.name
    fill_in "Order record", with: @family_record.order_record_id
    click_on "Create Family record"

    assert_text "Family record was successfully created"
    click_on "Back"
  end

  test "updating a Family record" do
    visit family_records_url
    click_on "Edit", match: :first

    fill_in "Description", with: @family_record.description
    fill_in "Name", with: @family_record.name
    fill_in "Order record", with: @family_record.order_record_id
    click_on "Update Family record"

    assert_text "Family record was successfully updated"
    click_on "Back"
  end

  test "destroying a Family record" do
    visit family_records_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Family record was successfully destroyed"
  end
end
