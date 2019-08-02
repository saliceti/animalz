class CreateSpeciesRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :species_records do |t|
      t.string :name
      t.string :description
      t.references :genus_record, foreign_key: true

      t.timestamps
    end
  end
end
