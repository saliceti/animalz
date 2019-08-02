json.extract! family_record, :id, :name, :description, :order_record_id, :created_at, :updated_at
json.url family_record_url(family_record, format: :json)
