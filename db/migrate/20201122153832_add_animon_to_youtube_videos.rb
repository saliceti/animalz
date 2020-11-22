class AddAnimonToYoutubeVideos < ActiveRecord::Migration[6.0]
  def change
    add_reference :youtube_videos, :animon, foreign_key: true
  end
end
