class CreateGenusRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :genus_records do |t|
      t.string :name
      t.string :description
      t.references :family_record, foreign_key: true

      t.timestamps
    end
  end
end
