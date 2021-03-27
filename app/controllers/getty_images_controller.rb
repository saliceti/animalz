class GettyImagesController < ApplicationController

  def new
    @animon = Animon.find(params[:animon_id])
    @getty_image = GettyImage.new(animon: @animon)
  end

  def create
    @getty_image = GettyImage.new(getty_image_params)
    @animon = Animon.find(getty_image_params[:animon_id])

    respond_to do |format|
      if @getty_image.save
        format.html { redirect_to @animon, notice: 'Getty image was successfully added.' }
      else
        format.html { render :new }
      end
    end

  end

  private
  def getty_image_params
    params.require(:getty_image).permit(:embed_code, :animon_id)
  end

end
