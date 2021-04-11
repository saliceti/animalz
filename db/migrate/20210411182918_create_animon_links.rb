class CreateAnimonLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :animon_links do |t|
      t.string :url
      t.string :title
      t.references :animon, null: false, foreign_key: true

      t.timestamps
    end
  end
end
