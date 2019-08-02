class ClassRecordsController < ApplicationController
  before_action :set_class_record, only: [:show, :edit, :update, :destroy]

  # GET /class_records
  # GET /class_records.json
  def index
    @class_records = ClassRecord.all
  end

  # GET /class_records/1
  # GET /class_records/1.json
  def show
  end

  # GET /class_records/new
  def new
    @class_record = ClassRecord.new
    prepare_form
    render status: 500 if @phylum_list.empty?
  end

  # GET /class_records/1/edit
  def edit
    prepare_form
  end

  # POST /class_records
  # POST /class_records.json
  def create
    @class_record = ClassRecord.new(class_record_params)
    respond_to do |format|
      if @class_record.save
        format.html { redirect_to @class_record, notice: 'Class record was successfully created.' }
        format.json { render :show, status: :created, location: @class_record }
      else
        prepare_form
        format.html { render :new }
        format.json { render json: @class_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /class_records/1
  # PATCH/PUT /class_records/1.json
  def update
    respond_to do |format|
      if @class_record.update(class_record_params)
        format.html { redirect_to @class_record, notice: 'Class record was successfully updated.' }
        format.json { render :show, status: :ok, location: @class_record }
      else
        prepare_form
        format.html { render :edit }
        format.json { render json: @class_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /class_records/1
  # DELETE /class_records/1.json
  def destroy
    @class_record.destroy
    respond_to do |format|
      format.html { redirect_to class_records_url, notice: 'Class record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_class_record
      @class_record = ClassRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def class_record_params
      params.require(:class_record).permit(:name, :description, :phylum_record_id)
    end

    def prepare_form
      @phylum_list = PhylumRecord.all
    end
end
