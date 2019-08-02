require 'test_helper'

class OrderRecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order_record = order_records(:one)
  end

  test "should get index" do
    get order_records_url
    assert_response :success
  end

  test "should get new" do
    get new_order_record_url
    assert_response :success
  end

  test "should create order_record" do
    assert_difference('OrderRecord.count') do
      post order_records_url, params: { order_record: { class_record_id: @order_record.class_record_id, description: @order_record.description, name: @order_record.name } }
    end

    assert_redirected_to order_record_url(OrderRecord.last)
  end

  test "should not create order_record if has no name" do
    assert_no_difference('OrderRecord.count') do
      post order_records_url, params: { order_record: { description: @order_record.description, name: "", class_record_id: @order_record.class_record_id } }
    end

    assert_response(:success)
  end

  test "should show order_record" do
    get order_record_url(@order_record)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_record_url(@order_record)
    assert_response :success
  end

  test "should update order_record" do
    patch order_record_url(@order_record), params: { order_record: { class_record_id: @order_record.class_record_id, description: @order_record.description, name: @order_record.name } }
    assert_redirected_to order_record_url(@order_record)
  end

  test "should not destroy order_record if has family" do
    assert_no_difference('OrderRecord.count') do
      delete order_record_url(@order_record)
    end

    assert_redirected_to order_records_url
  end

  test "should destroy order_record if has no family" do
    order_with_no_family = order_records(:order_with_no_family)
    assert_difference('OrderRecord.count', -1) do
      delete order_record_url(order_with_no_family)
    end

    assert_redirected_to order_records_url
  end
end
