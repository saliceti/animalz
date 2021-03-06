class TaxonsController < ApplicationController
  before_action :set_taxon, only: [:show, :edit, :update, :destroy]
  helper_method :parent_taxon, :rank_field

  def index
    if params[:rank]
      @rank = params[:rank]
      @taxons = Taxon.select_rank(@rank)
      @page_title = "#{@rank} list"
    else
      @taxons = Taxon.all
      @page_title = "Taxonomy"
    end
  end

  def show
    @ancestors = @taxon.ancestors
  end

  def new
    @taxons = Taxon.all
    @parent_taxon = Taxon.find(params[:readonly_parent_taxon]) if params[:readonly_parent_taxon]
    @rank = params[:rank] if params[:rank]
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
        @taxons = Taxon.all
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @taxon.update(taxon_params)
        format.html { redirect_to @taxon, notice: 'Taxon was successfully updated.' }
      else
        @taxons = Taxon.all
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
      form.collection_select(:parent_id, @taxons, :id, :rank_and_common_name, {:include_blank => ""}, {class: "border w-64"})
    end
  end

  def rank_field(form)
    if @rank
      buffer = form.hidden_field :rank, :value => @rank
      buffer << helpers.link_to(@rank, taxons_path(rank: @rank))
    else
      form.select(:rank, Taxon::RANKS, {:include_blank => ""}, {class: "border" })
    end
  end

  def set_taxon
    @taxon = Taxon.find(params[:id])
  end

  def taxon_params
    params.require(:taxon).permit(:rank, :common_name, :scientific_name, :parent_id, :wikipedia_page)
  end
end
