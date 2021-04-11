class AnimonLinksController < ApplicationController

  def new
    @animon = Animon.find(params[:animon_id])
    @animon_link = AnimonLink.new(animon: @animon)
  end

  def create
    @animon_link = AnimonLink.new(animon_link_params)
    @animon = Animon.find(animon_link_params[:animon_id])

    respond_to do |format|
      if @animon_link.save
        format.html { redirect_to @animon, notice: 'Link was successfully added.' }
      else
        format.html { render :new }
      end
    end

  end

  private

  def animon_link_params
    params.require(:animon_link).permit(:title, :url, :animon_id)
  end
end
