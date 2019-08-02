json.extract! order_record, :id, :name, :description, :class_record_id, :created_at, :updated_at
json.url order_record_url(order_record, format: :json)
