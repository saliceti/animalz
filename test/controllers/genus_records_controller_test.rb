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
    assert_form_contains_list_of FamilyRecord
  end

  test "should create genus_record" do
    assert_difference('GenusRecord.count') do
      post genus_records_url, params: { genus_record: { description: @genus_record.description, family_record_id: @genus_record.family_record_id, name: @genus_record.name } }
    end

    assert_redirected_to genus_record_url(GenusRecord.last)
  end

  test "should not create genus_record if has no name" do
    assert_no_difference('GenusRecord.count') do
      post genus_records_url, params: { genus_record: { description: @genus_record.description, name: "", family_record_id: @genus_record.family_record_id } }
    end

    assert_response(:success)
  end

  test "should show genus_record" do
    get genus_record_url(@genus_record)
    assert_response :success
  end

  test "should get edit" do
    get edit_genus_record_url(@genus_record)
    assert_response :success
    assert_form_contains_list_of FamilyRecord
  end

  test "should update genus_record" do
    patch genus_record_url(@genus_record), params: { genus_record: { description: @genus_record.description, family_record_id: @genus_record.family_record_id, name: @genus_record.name } }
    assert_redirected_to genus_record_url(@genus_record)
  end

  test "should not update genus_record if has no name" do
    patch genus_record_url(@genus_record), params: { genus_record: { description: @genus_record.description, family_record_id: @genus_record.family_record_id, name: "" } }
    assert @response.body.include?('Editing Genus Record')
    assert_response(:success)
    assert_form_contains_list_of FamilyRecord
  end

  test "should not destroy genus_record if has species" do
    assert_no_difference('GenusRecord.count') do
      delete genus_record_url(@genus_record)
    end

    assert_redirected_to genus_records_url
  end

  test "should destroy genus_record if empty" do
    genus_record_with_no_species = genus_records(:genus_record_with_no_species)
    assert_difference('GenusRecord.count', -1) do
      delete genus_record_url(genus_record_with_no_species)
    end

    assert_redirected_to genus_records_url
  end
end
