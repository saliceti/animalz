class CreateTaxons < ActiveRecord::Migration[6.0]
  def change
    create_table :taxons do |t|
      t.string :rank
      t.string :common_name
      t.string :scientific_name
      t.references :parent

      t.timestamps
    end
  end
end
