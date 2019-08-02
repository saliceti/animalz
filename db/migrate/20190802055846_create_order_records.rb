class CreateOrderRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :order_records do |t|
      t.string :name
      t.string :description
      t.references :class_record, foreign_key: true

      t.timestamps
    end
  end
end
