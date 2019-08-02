class FamilyRecordsController < ApplicationController
  before_action :set_family_record, only: [:show, :edit, :update, :destroy]

  # GET /family_records
  # GET /family_records.json
  def index
    @family_records = FamilyRecord.all
  end

  # GET /family_records/1
  # GET /family_records/1.json
  def show
  end

  # GET /family_records/new
  def new
    @family_record = FamilyRecord.new
    prepare_form
  end

  # GET /family_records/1/edit
  def edit
    prepare_form
  end

  # POST /family_records
  # POST /family_records.json
  def create
    @family_record = FamilyRecord.new(family_record_params)

    respond_to do |format|
      if @family_record.save
        format.html { redirect_to @family_record, notice: 'Family record was successfully created.' }
        format.json { render :show, status: :created, location: @family_record }
      else
        prepare_form
        format.html { render :new }
        format.json { render json: @family_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /family_records/1
  # PATCH/PUT /family_records/1.json
  def update
    respond_to do |format|
      if @family_record.update(family_record_params)
        format.html { redirect_to @family_record, notice: 'Family record was successfully updated.' }
        format.json { render :show, status: :ok, location: @family_record }
      else
        prepare_form
        format.html { render :edit }
        format.json { render json: @family_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /family_records/1
  # DELETE /family_records/1.json
  def destroy
    @family_record.destroy
    respond_to do |format|
      format.html { redirect_to family_records_url, notice: 'Family record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_family_record
      @family_record = FamilyRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def family_record_params
      params.require(:family_record).permit(:name, :description, :order_record_id)
    end

    def prepare_form
      @order_list = OrderRecord.all
    end
end
