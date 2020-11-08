class TaxonsController < ApplicationController
  before_action :set_taxon, only: [:show, :edit, :update, :destroy]
  helper_method :embed_link, :parent_taxon

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
    @parent_taxon = Taxon.find(params[:readonly_parent_taxon]) if params[:readonly_parent_taxon]
    @taxon = Taxon.new(parent: @parent_taxon)
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

  def parent_taxon(form)
    if params[:readonly_parent_taxon]
      buffer = form.hidden_field :parent_id, :value => @taxon.parent_id
      buffer << helpers.link_to(@taxon.parent.common_name, taxon_path(@taxon.parent))
    else
      form.collection_select(:parent_id, @taxons, :id, :rank_and_common_name, :include_blank => "")
    end
  end

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
