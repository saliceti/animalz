require 'test_helper'

class FamilyRecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @family_record = family_records(:one)
  end

  test "should get index" do
    get family_records_url
    assert_response :success
  end

  test "should get new" do
    get new_family_record_url
    assert_response :success
  end

  test "should create family_record" do
    assert_difference('FamilyRecord.count') do
      post family_records_url, params: { family_record: { description: @family_record.description, name: @family_record.name, order_record_id: @family_record.order_record_id } }
    end

    assert_redirected_to family_record_url(FamilyRecord.last)
  end

  test "should show family_record" do
    get family_record_url(@family_record)
    assert_response :success
  end

  test "should get edit" do
    get edit_family_record_url(@family_record)
    assert_response :success
  end

  test "should update family_record" do
    patch family_record_url(@family_record), params: { family_record: { description: @family_record.description, name: @family_record.name, order_record_id: @family_record.order_record_id } }
    assert_redirected_to family_record_url(@family_record)
  end

  test "should not destroy family_record if has genus" do
    assert_no_difference('FamilyRecord.count') do
      delete family_record_url(@family_record)
    end

    assert_redirected_to family_records_url
  end

  test "should destroy family_record if has no genus" do
    family_with_no_genus = family_records(:family_with_no_genus)
    assert_difference('FamilyRecord.count', -1) do
      delete family_record_url(family_with_no_genus)
    end

    assert_redirected_to family_records_url
  end
end
