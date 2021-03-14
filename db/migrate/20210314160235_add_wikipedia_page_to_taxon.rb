class AddWikipediaPageToTaxon < ActiveRecord::Migration[6.0]
  def change
    add_column :taxons, :wikipedia_page, :string
  end
end
