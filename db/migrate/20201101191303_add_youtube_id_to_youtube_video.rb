class AddYoutubeIdToYoutubeVideo < ActiveRecord::Migration[6.0]
  def change
    add_column :youtube_videos, :youtube_id, :string
  end
end
