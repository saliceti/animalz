class CreateGettyImages < ActiveRecord::Migration[6.0]
  def change
    create_table :getty_images do |t|
      t.string :embed_code
      t.references :animon, null: false, foreign_key: true

      t.timestamps
    end
  end
end
