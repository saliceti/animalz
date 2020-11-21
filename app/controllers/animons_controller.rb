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

  private

  def set_animon
    @animon = Animon.find(params[:id])
  end

  def animon_params
    params.require(:animon).permit(:taxon_id)
  end

end
