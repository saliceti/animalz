require 'test_helper'

class ClassRecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @class_record = class_records(:one)
  end

  test "should get index" do
    get class_records_url
    assert_response :success
  end

  test "should get new" do
    get new_class_record_url
    assert_response :success
    assert_form_contains_list_of PhylumRecord
  end

  test "should fail for new if no phylum" do
    SpeciesRecord.delete_all
    GenusRecord.delete_all
    FamilyRecord.delete_all
    OrderRecord.delete_all
    ClassRecord.delete_all
    PhylumRecord.delete_all
    get new_class_record_url

    assert_response(:error)
  end

  test "should create class_record" do
    assert_difference('ClassRecord.count') do
      post class_records_url, params: { class_record: { description: @class_record.description, name: @class_record.name, phylum_record_id: @class_record.phylum_record_id } }
    end

    assert_redirected_to class_record_url(ClassRecord.last)
  end

  test "should not create class_record if has no name" do
    assert_no_difference('ClassRecord.count') do
      post class_records_url, params: { class_record: { description: @class_record.description, name: "", phylum_record_id: @class_record.phylum_record_id } }
    end

    assert_response(:success)
  end

  test "should show class_record" do
    get class_record_url(@class_record)
    assert_response :success
  end

  test "should get edit" do
    get edit_class_record_url(@class_record)
    assert_response :success
    assert_form_contains_list_of PhylumRecord
  end

  test "should update class_record" do
    patch class_record_url(@class_record), params: { class_record: { description: @class_record.description, name: @class_record.name, phylum_record_id: @class_record.phylum_record_id } }
    assert_redirected_to class_record_url(@class_record)
  end

  test "should not update class_record if has no name" do
    patch class_record_url(@class_record), params: { class_record: { description: @class_record.description, name: "", phylum_record_id: @class_record.phylum_record_id } }
    assert @response.body.include?('Editing Class Record')
    assert_response(:success)
    assert_form_contains_list_of PhylumRecord
  end

  test "should not destroy class_record if has order" do
    assert_no_difference('ClassRecord.count') do
      delete class_record_url(@class_record)
    end

    assert_redirected_to class_records_url
  end

  test "should destroy class_record if has order" do
    class_with_no_order = class_records(:class_with_no_order)
    assert_difference('ClassRecord.count', -1) do
      delete class_record_url(class_with_no_order)
    end

    assert_redirected_to class_records_url
  end
end
