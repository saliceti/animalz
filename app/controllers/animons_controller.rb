class AnimonsController < ApplicationController
  before_action :set_animon, only: [:show, :edit, :update, :destroy]
  helper_method :embed_link, :picture

  def index
    if (params.has_key? :list) && (params[:list] == "latest")
      @animons = Animon.latest_created
      @page_title = "Latest animons"
    elsif params.has_key? :taxon
      taxon = Taxon.find(params[:taxon])
      @animons = Animon.all_animons_in_taxon taxon
      @page_title = "#{taxon.common_name}s"
    else
      @animons = Animon.all
      @page_title = "All animons"
    end
  end

  def show
  end

  def new
    @animon = Animon.new
    @animon.build_taxon
    @taxons = Taxon.available_species_and_subspecies
  end

  def edit
    @taxons = Taxon.available_species_and_subspecies @animon.taxon
  end

  def create
    if animon_params[:taxon_id] != ""
      new_params = animon_params.except(:taxon_attributes)
    else
      new_params = animon_params.except(:taxon_id)
    end
    @animon = Animon.new(new_params)
    @animon.picture.attach(new_params[:picture])

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
    if animon_params[:taxon_id] != ""
      update_params = animon_params.except(:taxon_attributes)
    else
      update_params = animon_params.except(:taxon_id)
    end

    @animon.picture.attach(update_params[:picture])
    respond_to do |format|
      if @animon.update(update_params)
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
    params.require(:animon).permit(:taxon_id, :twitter_handle, :picture, taxon_attributes: [:common_name, :scientific_name, :rank, :parent_id, :taxon])
  end

  def embed_link(youtube_id)
    "https://www.youtube.com/embed/#{youtube_id}"
  end

  def picture
    helpers.image_tag(url_for(@animon.picture), class: 'mt-4 mx-2 w-64') if @animon.picture.attached?
  end
end
