json.extract! class_record, :id, :name, :description, :phylum_record_id, :created_at, :updated_at
json.url class_record_url(class_record, format: :json)
