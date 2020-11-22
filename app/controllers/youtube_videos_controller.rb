class YoutubeVideosController < ApplicationController
  def new
    @animon = Animon.find(params[:animon])
    @video = YoutubeVideo.new(animon: @animon)
  end

  def create
    @video = YoutubeVideo.new(video_params)
    @animon = Animon.find(video_params[:animon_id])

    respond_to do |format|
      if @video.save
        format.html { redirect_to @animon, notice: 'Video was successfully added.' }
      else
        format.html { render :new }
      end
    end

  end

private
  def video_params
    params.require(:youtube_video).permit(:link, :animon_id)
  end

end
