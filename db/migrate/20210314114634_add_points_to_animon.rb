class AddPointsToAnimon < ActiveRecord::Migration[6.0]
  def change
    add_column :animons, :points, :integer, :default => 0
  end
end
