require 'test_helper'

class PhylumRecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @phylum_record = phylum_records(:one)
  end

  test "should get index" do
    get phylum_records_url
    assert_response :success
  end

  test "should get new" do
    get new_phylum_record_url
    assert_response :success
  end

  test "should create phylum_record" do
    assert_difference('PhylumRecord.count') do
      post phylum_records_url, params: { phylum_record: { description: @phylum_record.description, name: @phylum_record.name } }
    end

    assert_redirected_to phylum_record_url(PhylumRecord.last)
  end

  test "should show phylum_record" do
    get phylum_record_url(@phylum_record)
    assert_response :success
  end

  test "should get edit" do
    get edit_phylum_record_url(@phylum_record)
    assert_response :success
  end

  test "should update phylum_record" do
    patch phylum_record_url(@phylum_record), params: { phylum_record: { description: @phylum_record.description, name: @phylum_record.name } }
    assert_redirected_to phylum_record_url(@phylum_record)
  end

  test "should destroy phylum_record" do
    assert_difference('PhylumRecord.count', -1) do
      delete phylum_record_url(@phylum_record)
    end

    assert_redirected_to phylum_records_url
  end
end
