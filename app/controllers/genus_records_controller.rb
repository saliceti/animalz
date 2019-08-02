class GenusRecordsController < ApplicationController
  before_action :set_genus_record, only: [:show, :edit, :update, :destroy]

  # GET /genus_records
  # GET /genus_records.json
  def index
    @genus_records = GenusRecord.all
  end

  # GET /genus_records/1
  # GET /genus_records/1.json
  def show
  end

  # GET /genus_records/new
  def new
    @genus_record = GenusRecord.new
    prepare_form
  end

  # GET /genus_records/1/edit
  def edit
    prepare_form
  end

  # POST /genus_records
  # POST /genus_records.json
  def create
    @genus_record = GenusRecord.new(genus_record_params)

    respond_to do |format|
      if @genus_record.save
        format.html { redirect_to @genus_record, notice: 'Genus record was successfully created.' }
        format.json { render :show, status: :created, location: @genus_record }
      else
        prepare_form
        format.html { render :new }
        format.json { render json: @genus_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /genus_records/1
  # PATCH/PUT /genus_records/1.json
  def update
    respond_to do |format|
      if @genus_record.update(genus_record_params)
        format.html { redirect_to @genus_record, notice: 'Genus record was successfully updated.' }
        format.json { render :show, status: :ok, location: @genus_record }
      else
        prepare_form
        format.html { render :edit }
        format.json { render json: @genus_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /genus_records/1
  # DELETE /genus_records/1.json
  def destroy
    @genus_record.destroy
    respond_to do |format|
      format.html { redirect_to genus_records_url, notice: 'Genus record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_genus_record
      @genus_record = GenusRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def genus_record_params
      params.require(:genus_record).permit(:name, :description, :family_record_id)
    end

    def prepare_form
      @family_list = FamilyRecord.all
    end
end
