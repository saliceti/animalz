class CreateFamilyRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :family_records do |t|
      t.string :name
      t.string :description
      t.references :order_record, foreign_key: true

      t.timestamps
    end
  end
end
