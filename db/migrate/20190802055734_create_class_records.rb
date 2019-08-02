class CreateClassRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :class_records do |t|
      t.string :name
      t.string :description
      t.references :phylum_record, foreign_key: true

      t.timestamps
    end
  end
end
