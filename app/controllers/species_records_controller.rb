class SpeciesRecordsController < ApplicationController
  before_action :set_species_record, only: [:show, :edit, :update, :destroy]

  # GET /species_records
  # GET /species_records.json
  def index
    @species_records = SpeciesRecord.all
  end

  # GET /species_records/1
  # GET /species_records/1.json
  def show
  end

  # GET /species_records/new
  def new
    @species_record = SpeciesRecord.new
    prepare_form
  end

  # GET /species_records/1/edit
  def edit
    prepare_form
  end

  # POST /species_records
  # POST /species_records.json
  def create
    @species_record = SpeciesRecord.new(species_record_params)

    respond_to do |format|
      if @species_record.save
        format.html { redirect_to @species_record, notice: 'Species record was successfully created.' }
        format.json { render :show, status: :created, location: @species_record }
      else
        prepare_form
        format.html { render :new }
        format.json { render json: @species_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /species_records/1
  # PATCH/PUT /species_records/1.json
  def update
    respond_to do |format|
      if @species_record.update(species_record_params)
        format.html { redirect_to @species_record, notice: 'Species record was successfully updated.' }
        format.json { render :show, status: :ok, location: @species_record }
      else
        prepare_form
        format.html { render :edit }
        format.json { render json: @species_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /species_records/1
  # DELETE /species_records/1.json
  def destroy
    @species_record.destroy
    respond_to do |format|
      format.html { redirect_to species_records_url, notice: 'Species record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_species_record
      @species_record = SpeciesRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def species_record_params
      params.require(:species_record).permit(:name, :description, :genus_record_id)
    end

    def prepare_form
      @genus_list = GenusRecord.all
    end
end
