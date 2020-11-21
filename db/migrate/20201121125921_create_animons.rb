class CreateAnimons < ActiveRecord::Migration[6.0]
  def change
    create_table :animons do |t|
      t.references :taxon, null: false, foreign_key: true

      t.timestamps
    end
  end
end
