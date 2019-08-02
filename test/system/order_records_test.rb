require "application_system_test_case"

class OrderRecordsTest < ApplicationSystemTestCase
  setup do
    @order_record = order_records(:one)
  end

  test "visiting the index" do
    visit order_records_url
    assert_selector "h1", text: "Order Records"
  end

  test "creating a Order record" do
    visit order_records_url
    click_on "New Order Record"

    fill_in "Class record", with: @order_record.class_record_id
    fill_in "Description", with: @order_record.description
    fill_in "Name", with: @order_record.name
    click_on "Create Order record"

    assert_text "Order record was successfully created"
    click_on "Back"
  end

  test "updating a Order record" do
    visit order_records_url
    click_on "Edit", match: :first

    fill_in "Class record", with: @order_record.class_record_id
    fill_in "Description", with: @order_record.description
    fill_in "Name", with: @order_record.name
    click_on "Update Order record"

    assert_text "Order record was successfully updated"
    click_on "Back"
  end

  test "destroying a Order record" do
    visit order_records_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order record was successfully destroyed"
  end
end
