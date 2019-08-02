require 'test_helper'

class GenusRecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @genus_record = genus_records(:one)
  end

  test "should get index" do
    get genus_records_url
    assert_response :success
  end

  test "should get new" do
    get new_genus_record_url
    assert_response :success
  end

  test "should create genus_record" do
    assert_difference('GenusRecord.count') do
      post genus_records_url, params: { genus_record: { description: @genus_record.description, family_record_id: @genus_record.family_record_id, name: @genus_record.name } }
    end

    assert_redirected_to genus_record_url(GenusRecord.last)
  end

  test "should show genus_record" do
    get genus_record_url(@genus_record)
    assert_response :success
  end

  test "should get edit" do
    get edit_genus_record_url(@genus_record)
    assert_response :success
  end

  test "should update genus_record" do
    patch genus_record_url(@genus_record), params: { genus_record: { description: @genus_record.description, family_record_id: @genus_record.family_record_id, name: @genus_record.name } }
    assert_redirected_to genus_record_url(@genus_record)
  end

  test "should destroy genus_record" do
    assert_difference('GenusRecord.count', -1) do
      delete genus_record_url(@genus_record)
    end

    assert_redirected_to genus_records_url
  end
end
