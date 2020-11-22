class RemoveTaxonFromYoutubeVideos < ActiveRecord::Migration[6.0]
  def change
    remove_reference :youtube_videos, :taxon, null: false, foreign_key: true
  end
end
