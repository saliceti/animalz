class CreatePhylumRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :phylum_records do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
