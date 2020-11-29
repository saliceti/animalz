class AnimonsController < ApplicationController
  before_action :set_animon, only: [:show, :edit, :update, :destroy]
  helper_method :embed_link

  def index
    @animons = Animon.all
  end

  def show
  end

  def new
    @animon = Animon.new
    @taxons = Taxon.available_species_and_subspecies
  end

  def edit
    @taxons = Taxon.available_species_and_subspecies @animon.taxon
  end

  def create
    @animon = Animon.new(animon_params)
    respond_to do |format|
      if @animon.save
        format.html { redirect_to @animon, notice: 'Animon was successfully created.' }
      else
        @taxons = Taxon.available_species_and_subspecies @animon.taxon
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @animon.update(animon_params)
        format.html { redirect_to @animon, notice: 'Animon was successfully updated.' }
      else
        @taxons = Taxon.available_species_and_subspecies @animon.taxon
        format.html { render :edit }
      end
    end
  end

  def destroy
    @animon.destroy
    respond_to do |format|
      format.html { redirect_to animons_path, notice: 'Animon was successfully destroyed.' }
    end
  end

  private

  def set_animon
    @animon = Animon.find(params[:id])
  end

  def animon_params
    params.require(:animon).permit(:taxon_id, :twitter_handle)
  end

  def embed_link(youtube_id)
    "https://www.youtube.com/embed/#{youtube_id}"
  end

end
