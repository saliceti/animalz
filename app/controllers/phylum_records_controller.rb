class PhylumRecordsController < ApplicationController
  before_action :set_phylum_record, only: [:show, :edit, :update, :destroy]

  # GET /phylum_records
  # GET /phylum_records.json
  def index
    @phylum_records = PhylumRecord.all
  end

  # GET /phylum_records/1
  # GET /phylum_records/1.json
  def show
  end

  # GET /phylum_records/new
  def new
    @phylum_record = PhylumRecord.new
  end

  # GET /phylum_records/1/edit
  def edit
  end

  # POST /phylum_records
  # POST /phylum_records.json
  def create
    @phylum_record = PhylumRecord.new(phylum_record_params)

    respond_to do |format|
      if @phylum_record.save
        format.html { redirect_to @phylum_record, notice: 'Phylum record was successfully created.' }
        format.json { render :show, status: :created, location: @phylum_record }
      else
        format.html { render :new }
        format.json { render json: @phylum_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phylum_records/1
  # PATCH/PUT /phylum_records/1.json
  def update
    respond_to do |format|
      if @phylum_record.update(phylum_record_params)
        format.html { redirect_to @phylum_record, notice: 'Phylum record was successfully updated.' }
        format.json { render :show, status: :ok, location: @phylum_record }
      else
        format.html { render :edit }
        format.json { render json: @phylum_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phylum_records/1
  # DELETE /phylum_records/1.json
  def destroy
    @phylum_record.destroy
    respond_to do |format|
      format.html { redirect_to phylum_records_url, notice: 'Phylum record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phylum_record
      @phylum_record = PhylumRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def phylum_record_params
      params.require(:phylum_record).permit(:name, :description)
    end
end
