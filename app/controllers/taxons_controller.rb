class TaxonsController < ApplicationController
  before_action :set_taxon, only: [:show, :edit, :update, :destroy]

  def index
    @taxons = Taxon.all
  end

  def show
  end

  def new
    @taxons = Taxon.all
    @taxon = Taxon.new
  end

  def edit
    @taxons = Taxon.all
  end

  def create
    @taxon = Taxon.new(taxon_params)
    respond_to do |format|
      if @taxon.save
        format.html { redirect_to @taxon, notice: 'Taxon was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @taxon.update(taxon_params)
        format.html { redirect_to @taxon, notice: 'Taxon was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @taxon.destroy
    respond_to do |format|
      format.html { redirect_to taxons_path, notice: 'Taxon was successfully destroyed.' }
    end
  end

  private

  def set_taxon
    @taxon = Taxon.find(params[:id])
  end

  def taxon_params
    params.require(:taxon).permit(:rank, :common_name, :scientific_name, :parent_id)
  end
end
