class CreateYoutubeVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :youtube_videos do |t|
      t.string :link
      t.references :taxon, null: false, foreign_key: true

      t.timestamps
    end
  end
end
