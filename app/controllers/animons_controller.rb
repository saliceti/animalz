class AnimonsController < ApplicationController
  before_action :set_animon, only: [:show, :edit, :update, :destroy]

  def index
    @animons = Animon.all
  end

  def show
  end

  def new
    @animon = Animon.new
    @taxons = Taxon.available_species_and_subspecies
  end


  def create
    @animon = Animon.new(animon_params)
    respond_to do |format|
      if @animon.save
        format.html { redirect_to @animon, notice: 'Animon was successfully created.' }
      else
        @taxons = Taxon.available_species_and_subspecies
        format.html { render :new }
      end
    end
  end

  private

  def set_animon
    @animon = Animon.find(params[:id])
  end

  def animon_params
    params.require(:animon).permit(:taxon_id)
  end

end
