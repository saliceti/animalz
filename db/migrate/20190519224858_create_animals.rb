class CreateAnimals < ActiveRecord::Migration[5.2]
  def change
    create_table :animals do |t|
      t.string :name
      t.references :family, foreign_key: true

      t.timestamps
    end
  end
end
