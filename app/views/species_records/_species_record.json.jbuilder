json.extract! species_record, :id, :name, :description, :genus_record_id, :created_at, :updated_at
json.url species_record_url(species_record, format: :json)
