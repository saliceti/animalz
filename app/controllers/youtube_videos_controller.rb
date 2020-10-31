class YoutubeVideosController < ApplicationController
  def new
    @taxon = Taxon.find(params[:taxon])
    @video = YoutubeVideo.new(taxon: @taxon)
  end


  def create
    @video = YoutubeVideo.new(video_params)
    @taxon = Taxon.find(video_params[:taxon_id])

    respond_to do |format|
      if @video.save
        format.html { redirect_to @taxon, notice: 'Video was successfully added.' }
      else
        format.html { render :new }
      end
    end

  end

private
  def video_params
    params.require(:youtube_video).permit(:link, :taxon_id)
  end

end
