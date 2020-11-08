class TaxonsController < ApplicationController
  before_action :set_taxon, only: [:show, :edit, :update, :destroy]
  helper_method :embed_link

  def index
    if params[:rank]
      @taxons = Taxon.select_rank(params[:rank])
      @page_title = "#{params[:rank]} list"
    else
      @taxons = Taxon.all
      @page_title = "All taxons"
    end
  end

  def show
    @ancestors = @taxon.ancestors
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

  def embed_link(youtube_id)
    "https://www.youtube.com/embed/#{youtube_id}"
  end

  def set_taxon
    @taxon = Taxon.find(params[:id])
  end

  def taxon_params
    params.require(:taxon).permit(:rank, :common_name, :scientific_name, :parent_id)
  end
end
