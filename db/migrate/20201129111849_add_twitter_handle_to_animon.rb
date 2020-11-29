class AddTwitterHandleToAnimon < ActiveRecord::Migration[6.0]
  def change
    add_column :animons, :twitter_handle, :string
  end
end
