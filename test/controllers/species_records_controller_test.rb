require 'test_helper'

class SpeciesRecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @species_record = species_records(:one)
  end

  test "should get index" do
    get species_records_url
    assert_response :success
  end

  test "should get new" do
    get new_species_record_url
    assert_response :success
    assert_form_contains_list_of GenusRecord
  end

  test "should create species_record" do
    assert_difference('SpeciesRecord.count') do
      post species_records_url, params: { species_record: { description: @species_record.description, genus_record_id: @species_record.genus_record_id, name: @species_record.name } }
    end

    assert_redirected_to species_record_url(SpeciesRecord.last)
  end

  test "should not create species_record if has no name" do
    assert_no_difference('SpeciesRecord.count') do
      post species_records_url, params: { species_record: { description: @species_record.description, name: "", genus_record_id: @species_record.genus_record_id } }
    end

    assert_response(:success)
  end

  test "should show species_record" do
    get species_record_url(@species_record)
    assert_response :success
  end

  test "should get edit" do
    get edit_species_record_url(@species_record)
    assert_response :success
    assert_form_contains_list_of GenusRecord
  end

  test "should update species_record" do
    patch species_record_url(@species_record), params: { species_record: { description: @species_record.description, genus_record_id: @species_record.genus_record_id, name: @species_record.name } }
    assert_redirected_to species_record_url(@species_record)
  end

  test "should not update species_record if has no name" do
    patch species_record_url(@species_record), params: { species_record: { description: @species_record.description, genus_record_id: @species_record.genus_record_id, name: "" } }
    assert @response.body.include?('Editing Species Record')
    assert_response(:success)
    assert_form_contains_list_of GenusRecord
  end

  test "should destroy species_record" do
    assert_difference('SpeciesRecord.count', -1) do
      delete species_record_url(@species_record)
    end

    assert_redirected_to species_records_url
  end
end
