json.extract! genus_record, :id, :name, :description, :family_record_id, :created_at, :updated_at
json.url genus_record_url(genus_record, format: :json)
