class AddFamilyRefToAnimals < ActiveRecord::Migration[5.2]
  def change
    add_reference :animals, :family, foreign_key: true
  end
end
